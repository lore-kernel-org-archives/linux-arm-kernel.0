From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 29 Jul 2015 15:17:13 +0800
Subject: [PATCH v5 01/10] clk: mediatek: Removed unused dpi_ck clock
 from MT8173
In-Reply-To: <6282882.pftQBj38E3@diego>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438152754-11970-2-git-send-email-jamesjj.liao@mediatek.com>
 <6282882.pftQBj38E3@diego>
Message-ID: <1438154233.17770.39.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Could you help to apply this patch into 4.2?


Best regards,

James

On Wed, 2015-07-29 at 09:05 +0200, Heiko St?bner wrote:
> Am Mittwoch, 29. Juli 2015, 14:52:25 schrieb James Liao:
> > The dpi_ck clock can be removed because it not actually used
> > in topckgen and subsystems.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> 
> From our past discussions this change looks about right, and should still 
> become _part of 4.2_, to not have the CLK_TOP_DPI become part of the 
> devicetree CLK_TOP_DPI.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> > ---
> >  drivers/clk/mediatek/clk-mt8173.c      | 1 -
> >  include/dt-bindings/clock/mt8173-clk.h | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt8173.c
> > b/drivers/clk/mediatek/clk-mt8173.c index 4b9e04c..4486f8f 100644
> > --- a/drivers/clk/mediatek/clk-mt8173.c
> > +++ b/drivers/clk/mediatek/clk-mt8173.c
> > @@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(mt8173_clk_lock);
> > 
> >  static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> >  	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> > -	FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
> >  	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> >  	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> >  };
> > diff --git a/include/dt-bindings/clock/mt8173-clk.h
> > b/include/dt-bindings/clock/mt8173-clk.h index 4ad76ed..7230c38 100644
> > --- a/include/dt-bindings/clock/mt8173-clk.h
> > +++ b/include/dt-bindings/clock/mt8173-clk.h
> > @@ -18,7 +18,6 @@
> >  /* TOPCKGEN */
> > 
> >  #define CLK_TOP_CLKPH_MCK_O		1
> > -#define CLK_TOP_DPI			2
> >  #define CLK_TOP_USB_SYSPLL_125M		3
> >  #define CLK_TOP_HDMITX_DIG_CTS		4
> >  #define CLK_TOP_ARMCA7PLL_754M		5
> 
