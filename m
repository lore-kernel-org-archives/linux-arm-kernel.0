From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 23:16:11 +0800
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
Message-ID: <20120820151609.GN24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:54:48AM -0500, Matt Sealey wrote:
> Yet another arbitrary array...
> 
> I'm not sure why you would move the registration lookup into the DT

Because I do not want to patch kernel every time I need a new lookup.
Furthermore, looking at function imx53_qsb_init in imx53-dt.c, you
will find that lookup for sgtl5000 is really board specific and should
go to device tree.

> and use an arbitrarily ordered array again. Sure, you're looking it up
> entirely within the device tree here, but a better solution would be
> to not name clocks twice, and structure your clock definition
> properly.
> 
> What's wrong with;
> 
> ccm at 020c4000 {
>    ...
>    my_clock: clock at 0 {
>        name = "my_clock_name";
>    }
> }
> 
> uart at nnnnnnnn {
>    ...
>    clocks = <&my_clock>;
> }
> 
> ?
> 
It turns a property into 185 nodes, which will just bloat the device
tree.  This issue has been discussed for a plenty of times.

-- 
Regards,
Shawn
