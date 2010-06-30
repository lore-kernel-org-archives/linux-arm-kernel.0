From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 20:17:28 +0200
Subject: [PATCH 27/33] Removing dead IDE_PXA_CF
In-Reply-To: <a332e637ee15cb15f7099f5dfc19a384b2bf772b.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<a332e637ee15cb15f7099f5dfc19a384b2bf772b.1277911346.git.siccegge@cs.fau.de>
Message-ID: <201006302017.28731.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 18:02:32 Christoph Egger napsal(a):
> IDE_PXA_CF doesn't exist in Kconfig, therefore removing all references
> for it from the source code.

This thing would be on purpose I believe ... maybe documenting it better won't 
hurt though.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-pxa/trizeps4.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
> index 6968911..0acff17 100644
> --- a/arch/arm/mach-pxa/trizeps4.c
> +++ b/arch/arm/mach-pxa/trizeps4.c
> @@ -530,13 +530,9 @@ static void __init trizeps4_init(void)
>  	i2c_register_board_info(0, trizeps4_i2c_devices,
>  					ARRAY_SIZE(trizeps4_i2c_devices));
> 
> -#ifdef CONFIG_IDE_PXA_CF
> -	/* if boot direct from compact flash dont disable power */
> -	trizeps_conxs_bcr = 0x0009;
> -#else
>  	/* this is the reset value */
>  	trizeps_conxs_bcr = 0x00A0;
> -#endif
> +
>  	BCR_writew(trizeps_conxs_bcr);
>  	board_backlight_power(1);
>  }
