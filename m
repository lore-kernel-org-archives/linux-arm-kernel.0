From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Sep 2017 10:44:45 -0700
Subject: [PATCH] arm: omap: dra7xx: Set OPT_CLKS_IN_RESET flag for gpio1
In-Reply-To: <c8768202-96e1-8bda-7e09-ddf296c19c57@ti.com>
References: <1504694038-32159-1-git-send-email-j-keerthy@ti.com>
 <c8768202-96e1-8bda-7e09-ddf296c19c57@ti.com>
Message-ID: <20170919174444.GA5024@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [170918 04:40]:
> 
> 
> On Wednesday 06 September 2017 04:03 PM, Keerthy wrote:
> > gpio1 soft reset fails in the kexec path as the optional clock
> > is not enabled hence enable the HWMOD_CONTROL_OPT_CLKS_IN_RESET
> > flag for gpio1 hwmod.
> 
> A gentle ping on this as well.

With v4.14-rc1 now out, applying into omap-for-v4.14/fixes.
I usually don't start applying fixes during the merge window
unless really needed.

Regards,

Tony


> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > index 7cc3247..6ae729a 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> > @@ -1037,6 +1037,7 @@ struct omap_hwmod dra7xx_sha0_hwmod = {
> >  	.name		= "gpio1",
> >  	.class		= &dra7xx_gpio_hwmod_class,
> >  	.clkdm_name	= "wkupaon_clkdm",
> > +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> >  	.main_clk	= "wkupaon_iclk_mux",
> >  	.prcm = {
> >  		.omap4 = {
> > 
