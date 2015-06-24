From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 24 Jun 2015 15:54:15 +0800
Subject: [PATCH] arm64: dts: mt8173: add clock_null
In-Reply-To: <8860488.JuX1EN5tWB@diego>
References: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
 <8371528.SNAmOgosfF@phil> <1434944317.25948.8.camel@mtksdaap41>
 <8860488.JuX1EN5tWB@diego>
Message-ID: <1435132455.28866.21.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Mon, 2015-06-22 at 14:53 +0200, Heiko St?bner wrote:
> Hi James,
> 
> Am Montag, 22. Juni 2015, 11:38:37 schrieb James Liao:
> > On Fri, 2015-06-19 at 13:36 +0200, Heiko Stuebner wrote:
> > 
> > Some clocks such as clkph_mck_o, we don't really care where they come
> > from and what frequencies are. We model these clocks just because they
> > or their derived clocks can be the source of topckgen muxes. Is there a
> > better way to model "don't care" clocks?
> 
> There are two different concepts at work here. You might not care in your 
> kernel driver implementation _at the moment_ where the clocks come from; but 
> the devicetree is supposed to model how the hardware is structured and not 
> contain implementation specific details.

If we model "don't care" clocks inside the driver (i.e. create clk_null
in clock driver), then we don't need to model the dummy clock in device.
Is it an acceptable way?

> So the clock tree should be modeled according to how the hardware is layed out 
> not how you want to use the clocks at the moment :-) .
> 
> It would it any case be good, if you could describe where these clocks come 
> from in the hardware, so we can find the best solution on how to model those.

In fact, I don't know where these clocks come from at all, especially
when they come from outside of SoC. Besides, some clocks don't need to
model in CCF, but they can be the source of clocks that controlled by
CCF.

I don't think ALL clocks on a SoC need to be handled in CCF, so there
should be some clocks don't have a "real" or "correct" parent. In
current implementation I use a dummy clock (clk_null) to be the unreal
parent.

Do you think we should model as more clocks as we can in CCF even we
don't need them? If no, how do we handle those clocks which are not
handled in CCF but can be parent of CCF clocks?


Best regards,

James
