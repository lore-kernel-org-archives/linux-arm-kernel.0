From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 18 Apr 2010 04:43:56 +0200
Subject: [RFC PATCH 06/10] mx5: rename mx51_map_io to mx5_map_io
In-Reply-To: <1271446524-26450-7-git-send-email-r.herring@freescale.com>
References: <1271446524-26450-7-git-send-email-r.herring@freescale.com>
Message-ID: <20100418024356.GD7882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 02:35:20PM -0500, Rob Herring wrote:
> Signed-off-by: Rob Herring <r.herring@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c  |    2 +-
>  arch/arm/mach-mx5/mm.c                  |    2 +-
>  arch/arm/plat-mxc/include/mach/common.h |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index ee67a71..5c15d6e 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -91,7 +91,7 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
>  	.phys_io = MX51_AIPS1_BASE_ADDR,
>  	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
>  	.boot_params = PHYS_OFFSET + 0x100,
> -	.map_io = mx51_map_io,
> +	.map_io = mx5_map_io,

I think we should leave this as is and use a mx53_map_io for i.MX53.
Then we can skip the somewhat mystical CPU detection later in this
series.

>  	.init_irq = mx51_init_irq,
>  	.init_machine = mxc_board_init,
>  	.timer = &mxc_timer,
> diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
> index fedacac..8ad1d0c 100644
> --- a/arch/arm/mach-mx5/mm.c
> +++ b/arch/arm/mach-mx5/mm.c
> @@ -38,7 +38,7 @@ static struct map_desc mxc_io_desc[] __initdata = {
>   * system startup to create static physical to virtual memory mappings
>   * for the IO modules.
>   */
> -void __init mx51_map_io(void)
> +void __init mx5_map_io(void)
>  {
>  	void __iomem *base;
>  
> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 2941472..0766746 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -20,7 +20,7 @@ extern void mx25_map_io(void);
>  extern void mx27_map_io(void);
>  extern void mx31_map_io(void);
>  extern void mx35_map_io(void);
> -extern void mx51_map_io(void);
> +extern void mx5_map_io(void);
>  extern void mxc91231_map_io(void);
>  extern void mxc_init_irq(void __iomem *);
>  extern void tzic_init_irq(void __iomem *);
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
