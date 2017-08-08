From: icenowy@aosc.io (icenowy at aosc.io)
Date: Tue, 08 Aug 2017 15:11:27 +0800
Subject: [linux-sunxi] Re: [PATCH v2] mmc: sunxi: Fix NULL pointer
 reference on clk_delays
In-Reply-To: <CAGb2v65qN9OFCnjSRH-=a-XnKEfOJXh=Gvv02vtPydgVEnKuGw@mail.gmail.com>
References: <20170808070244.27410-1-wens@csie.org>
 <bbd4680dc97d9913ff6a49e68c360d21@aosc.io>
 <CAGb2v65qN9OFCnjSRH-=a-XnKEfOJXh=Gvv02vtPydgVEnKuGw@mail.gmail.com>
Message-ID: <b9e0274b343e329d82f789a76d62c25c@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-08 15:10?Chen-Yu Tsai ???
> On Tue, Aug 8, 2017 at 3:07 PM,  <icenowy@aosc.io> wrote:
>> ? 2017-08-08 15:02?Chen-Yu Tsai ???
>>> 
>>> Some SoCs do not support clk delays for MMC in the clock control 
>>> unit.
>>> These include the old controllers in A10/A10s/A13/R8, and the new 
>>> eMMC
>>> controller in A64. The config structure for these controllers do not
>>> specify clk_delays, but the check for this was replaced in commit
>>> b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
>>> and new timings").
>>> 
>>> This patch adds back the check for clk_delays, and also adds comments
>>> for both checks in sunxi_mmc_clk_set_phase().
>>> 
>>> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>>>                       both old and new timings")
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> 
>> 
>> Should I add a Tested-by here?
> 
> If you tested it, then yes. :)

I tested it on A64 MMC2.

So:

Tested-by: Icenowy Zheng <icenowy@aosc.io>

> 
> ChenYu
