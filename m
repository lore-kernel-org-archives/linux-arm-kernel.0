From: daniel@zonque.org (Daniel Mack)
Date: Wed, 9 Dec 2015 18:05:36 +0100
Subject: [PATCH] ARM: pxa: mark raumfeld init functions as __maybe_unused
In-Reply-To: <2245032.bpQt17WIoe@wuerfel>
References: <2245032.bpQt17WIoe@wuerfel>
Message-ID: <56685F60.6030200@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2015 05:52 PM, Arnd Bergmann wrote:
> The raumfeld.c file contains three similar machine definitions,
> each with their own init function. If one or more of them are
> disabled, we get compile-time warnings:
> 
> arm/mach-pxa/raumfeld.c:1070:123: warning: 'raumfeld_connector_init' defined but not used [-Wunused-function]
> arm/mach-pxa/raumfeld.c:1082:123: warning: 'raumfeld_speaker_init' defined but not used [-Wunused-function]
> 
> This marks the functions as __maybe_unused to avoid the warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Daniel Mack <daniel@zonque.org>

Thanks!


> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 0f67d94be297..8347d87a713d 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -1046,7 +1046,7 @@ static void __init raumfeld_common_init(void)
>  	i2c_register_board_info(1, &raumfeld_pwri2c_board_info, 1);
>  }
>  
> -static void __init raumfeld_controller_init(void)
> +static void __init __maybe_unused raumfeld_controller_init(void)
>  {
>  	int ret;
>  
> @@ -1067,7 +1067,7 @@ static void __init raumfeld_controller_init(void)
>  	raumfeld_w1_init();
>  }
>  
> -static void __init raumfeld_connector_init(void)
> +static void __init __maybe_unused raumfeld_connector_init(void)
>  {
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_connector_pin_config));
>  	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
> @@ -1079,7 +1079,7 @@ static void __init raumfeld_connector_init(void)
>  	raumfeld_common_init();
>  }
>  
> -static void __init raumfeld_speaker_init(void)
> +static void __init __maybe_unused raumfeld_speaker_init(void)
>  {
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_speaker_pin_config));
>  	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
> 
