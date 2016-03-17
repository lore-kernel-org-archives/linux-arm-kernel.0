From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Mar 2016 17:06:56 +0100
Subject: [RESEND PATCH] ARM: at91/dt: sama5d2: add SFR node
In-Reply-To: <1458230640-26049-1-git-send-email-ludovic.desroches@atmel.com>
References: <1458230640-26049-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160317160656.GA2831@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2016 at 17:04:00 +0100, Ludovic Desroches wrote :
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> This SFR node is looked up by the I2S controller driver to tune the
> SFR_I2SCLKSEL register.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.txt |  2 +-
>  arch/arm/boot/dts/sama5d2.dtsi                       |  5 +++++
>  include/soc/at91/atmel-sfr.h                         | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 include/soc/at91/atmel-sfr.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 7fd64ec..550fd66 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -155,7 +155,7 @@ elsewhere.
>  
>  required properties:
>  - compatible: Should be "atmel,<chip>-sfr", "syscon".
> -  <chip> can be "sama5d3" or "sama5d4".
> +  <chip> can be "sama5d3", "sama5d4" or "sama5d2".
>  - reg: Should contain registers location and length
>  
>  	sfr at f0038000 {
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 78996bd..36bb29c 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -973,6 +973,11 @@
>  				status = "disabled";
>  			};
>  
> +			sfr: sfr at f8030000 {
> +				compatible = "atmel,sama5d2-sfr", "syscon";
> +				reg = <0xf8030000 0x98>;
> +			};
> +
>  			flx0: flexcom at f8034000 {
>  				compatible = "atmel,sama5d2-flexcom";
>  				reg = <0xf8034000 0x200>;
> diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
> new file mode 100644
> index 0000000..2f9bb98
> --- /dev/null
> +++ b/include/soc/at91/atmel-sfr.h
> @@ -0,0 +1,18 @@
> +/*
> + * Atmel SFR (Special Function Registers) register offsets and bit definitions.
> + *
> + * Copyright (C) 2016 Atmel
> + *
> + * Author: Ludovic Desroches <ludovic.desroches@atmel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _LINUX_MFD_SYSCON_ATMEL_SFR_H
> +#define _LINUX_MFD_SYSCON_ATMEL_SFR_H
> +
> +#define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
> +
> +#endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
