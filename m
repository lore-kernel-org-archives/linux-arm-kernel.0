From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Nov 2010 11:30:13 +0100
Subject: [PATCH 1/7] ARM i.MX51 boards: Do not use PHYS_OFFSET
In-Reply-To: <1288950371-1552-2-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
	<1288950371-1552-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20101105103013.GH16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Sascha,

On Fri, Nov 05, 2010 at 10:46:05AM +0100, Sascha Hauer wrote:
> PHYS_OFFSET may become a variable once the runtime PHYS_OFFSET
> patch is merged, so use MX51_PHYS_OFFSET for boot_params.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx5/board-cpuimx51.c   |    2 +-
>  arch/arm/mach-mx5/board-cpuimx51sd.c |    2 +-
>  arch/arm/mach-mx5/board-mx51_3ds.c   |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> index 6a9792f..1e01ec7 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> @@ -292,7 +292,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
>  	/* Maintainer: Eric B?nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = MX51_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51_init,
> diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
> index 4b3a611..24bbdb8 100644
> --- a/arch/arm/mach-mx5/board-cpuimx51sd.c
> +++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
> @@ -323,7 +323,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
>  	/* Maintainer: Eric B?nard <eric@eukrea.com> */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = MX51_PHYS_OFFSET + 0x100,
>  	.map_io = mx51_map_io,
>  	.init_irq = mx51_init_irq,
>  	.init_machine = eukrea_cpuimx51sd_init,
> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
> index 79ce8dc..873cc1f 100644
> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
> @@ -186,7 +186,7 @@ static struct sys_timer mxc_timer = {
>  
>  MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
>  	/* Maintainer: Freescale Semiconductor, Inc. */
> -	.boot_params = PHYS_OFFSET + 0x100,
> +	.boot_params = MX3x_PHYS_OFFSET + 0x100,
This looks wrong.

Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
