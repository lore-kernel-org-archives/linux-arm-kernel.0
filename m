From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 7 Apr 2015 21:32:15 +0200
Subject: [PATCH 2/2] ARM: at91/dt: add support for kizboxmini.
In-Reply-To: <1428415884-30662-3-git-send-email-g.portay@overkiz.com>
References: <1428415884-30662-1-git-send-email-g.portay@overkiz.com>
 <1428415884-30662-3-git-send-email-g.portay@overkiz.com>
Message-ID: <20150407193215.GX20669@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/04/2015 at 16:11:24 +0200, Ga?l PORTAY wrote :
> Add DT file for Kizbox mini board.
> This board is based on Atmel's AT91SAM9G25 SoC.
> 
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> ---
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/at91-kizboxmini.dts | 129 ++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a1c776b..9c11888 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -30,6 +30,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
>  	at91sam9rlek.dtb \
>  	at91-ariag25.dtb \
>  	at91-cosino_mega2560.dtb \
> +	at91-kizboxmini.dtb \
>  	at91sam9g15ek.dtb \
>  	at91sam9g25ek.dtb \
>  	at91sam9g35ek.dtb \
> diff --git a/arch/arm/boot/dts/at91-kizboxmini.dts b/arch/arm/boot/dts/at91-kizboxmini.dts
> new file mode 100644
> index 0000000..191576c
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-kizboxmini.dts
> @@ -0,0 +1,129 @@
> +/*
> + * at91-kizboxmini.dts - Device Tree file for Overkiz Kizbox mini board
> + *
> + * Copyright (C) 2014 Ga?l PORTAY <g.portay@overkiz.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +#include "at91sam9g25.dtsi"
> +#include "at91sam9x5.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Overkiz Kizbox mini";
> +	compatible = "overkiz,kizboxmini", "atmel,at91sam9g25ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";

I would remove "atmel,at91sam9g25ek" and "atmel,at91sam9x5ek". However,
you could use "atmel,at91sam9g25".

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
