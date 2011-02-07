From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Feb 2011 17:51:50 +0100
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
Message-ID: <20110207165150.GG27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 04, 2011 at 08:22:37PM +0000, Russell King - ARM Linux wrote:
> As PHYS_OFFSET will be becoming a variable, we can't have it used in
> initializers nor assembly code.  Replace those in generic code with
> a run-time initialization.  Replace those in platform code using the
> individual platform specific PLAT_PHYS_OFFSET.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  ....
>  arch/arm/mach-mx5/board-cpuimx51.c       |    2 +-
>  arch/arm/mach-mx5/board-cpuimx51sd.c     |    2 +-
>  arch/arm/mach-mx5/board-mx51_3ds.c       |    2 +-
> ...
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 6a9792f..c4c3a9c 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -292,7 +292,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
>  	/* Maintainer: Eric B??nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51_init,
> diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
> index 4b3a611..b887381 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51sd.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
> @@ -323,7 +323,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
>  	/* Maintainer: Eric B??nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51sd_init,
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index 79ce8dc..10e6ce3 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -186,7 +186,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
>  	/* Maintainer: Freescale Semiconductor, Inc. */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = PLAT_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = mxc_board_init,
nack.  7608d7d2b4a146f560436f5b99b1b93d30049e4e has a better fix.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
