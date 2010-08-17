From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 17 Aug 2010 15:01:52 +0300
Subject: [PATCH 2/2] i.MX35: Add EPIT support
In-Reply-To: <1282044218-14809-3-git-send-email-m.grzeschik@pengutronix.de>
References: <1282044218-14809-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282044218-14809-3-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20100817120152.GD9631@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael, Sascha,

On Tue, Aug 17, 2010 at 01:23:38PM +0200, Michael Grzeschik wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---

[snip]

> diff --git a/arch/arm/plat-mxc/include/mach/common.h 
> b/arch/arm/plat-mxc/include/mach/common.h
> index 2941472..7a1e1f8 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -32,6 +32,7 @@ extern void mx31_init_irq(void);
>  extern void mx35_init_irq(void);
>  extern void mx51_init_irq(void);
>  extern void mxc91231_init_irq(void);
> +extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
>  extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
>  extern int mx1_clocks_init(unsigned long fref);
>  extern int mx21_clocks_init(unsigned long lref, unsigned long fref);

This hunk should probably be moved to the previous patch, where 
epit_timer_init is defined.

baruch

> -- 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
