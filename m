From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 22 Jun 2015 11:38:37 +0800
Subject: [PATCH] arm64: dts: mt8173: add clock_null
In-Reply-To: <8371528.SNAmOgosfF@phil>
References: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
 <2333431.ttvjElY3ps@phil> <8371528.SNAmOgosfF@phil>
Message-ID: <1434944317.25948.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Fri, 2015-06-19 at 13:36 +0200, Heiko Stuebner wrote:
> Am Donnerstag, 18. Juni 2015, 18:15:03 schrieb Heiko Stuebner:
> > Am Donnerstag, 18. Juni 2015, 13:29:11 schrieb Eddie Huang:
> > > Add clk_null, which represents clocks that can not / need not
> > > controlled by software.
> > > There are many clocks' parent set to clk_null.
> > 
> > Devicetree is supposed to describe hardware, and ideally not what software
> > does with it. If the clock simply cannot be controlled by software, it will
> > still have a rate and I think it should probably be modelled - similarly we
> > sometimes have fixed regulators that also are not software controllable.
> > 
> > 
> > While it might be ok to define dummy clocks as a temporary stopgap, these
> > should definitly be marked as such. This clk_null at least sounds like there
> > is no plan to replace this with a real solution at some point.
> > 
> > And of course a bit of context would be cool, to know which type of clocks
> > this actually replaces.
> 
> After looking a bit more into this, I'm feel that the clk_null approach is 
> wrong.
> 
> For one, even if the clk_null stuff would be ok, the binding doc of the clock 
> controller does not describe the need of this specific clock at all.
> 
> 
> The other more important point, looking at clk-mt8173 I see at least these 
> clocks being set as children of "clk_null":
> 
> static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> 	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> 	FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
> 	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> 	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> };
> 
> 
> These look more like they are fed from some external source to the clock 
> controller? I did ask Matthias but he also couldn't find anything describing 
> where these clocks actually come from.

Some clocks such as clkph_mck_o, we don't really care where they come
from and what frequencies are. We model these clocks just because they
or their derived clocks can be the source of topckgen muxes. Is there a
better way to model "don't care" clocks?


Best regards,

James
