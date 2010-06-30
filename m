From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 20:24:46 +0200
Subject: [PATCH 17/33] Removing dead SX1_OLD_FLASH
In-Reply-To: <5b21086199b139a61888c16e92d3efe6b205dae2.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<5b21086199b139a61888c16e92d3efe6b205dae2.1277911346.git.siccegge@cs.fau.de>
Message-ID: <201006302024.47025.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 17:59:25 Christoph Egger napsal(a):
> SX1_OLD_FLASH doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

There were two models of the phone made, you can toggle between old and new 
version. Maybe better documentation won't hurt.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap1/board-sx1.c |   26 --------------------------
>  1 files changed, 0 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-sx1.c
> b/arch/arm/mach-omap1/board-sx1.c index 2fb1e5f..1de809d 100644
> --- a/arch/arm/mach-omap1/board-sx1.c
> +++ b/arch/arm/mach-omap1/board-sx1.c
> @@ -295,31 +295,6 @@ static struct physmap_flash_data sx1_flash_data = {
>  	.nr_parts	= ARRAY_SIZE(sx1_partitions),
>  };
> 
> -#ifdef CONFIG_SX1_OLD_FLASH
> -/* MTD Intel StrataFlash - old flashes */
> -static struct resource sx1_old_flash_resource[] = {
> -	[0] = {
> -		.start	= OMAP_CS0_PHYS,	/* Physical */
> -		.end	= OMAP_CS0_PHYS + SZ_16M - 1,,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= OMAP_CS1_PHYS,
> -		.end	= OMAP_CS1_PHYS + SZ_8M - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct platform_device sx1_flash_device = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &sx1_flash_data,
> -	},
> -	.num_resources	= 2,
> -	.resource	= &sx1_old_flash_resource,
> -};
> -#else
>  /* MTD Intel 4000 flash - new flashes */
>  static struct resource sx1_new_flash_resource = {
>  	.start		= OMAP_CS0_PHYS,
> @@ -336,7 +311,6 @@ static struct platform_device sx1_flash_device = {
>  	.num_resources	= 1,
>  	.resource	= &sx1_new_flash_resource,
>  };
> -#endif
> 
>  /*----------- USB -------------------------*/
