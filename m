From: csd@broadcom.com (Christian Daudt)
Date: Thu, 4 Jul 2013 09:26:28 -0700
Subject: [PATCH] ARM: bcm281xx: Adding bcm28155-ap.dts
In-Reply-To: <1371684254-15189-1-git-send-email-markus.mayer@linaro.org>
References: <1371684254-15189-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <51D5A234.6080304@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-19 04:24 PM, Markus Mayer wrote:
> Add support for the BCM28155 AP board.
>
> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> Acked-by: Christian Daudt <csd@broadcom.com>
> ---
>   arch/arm/boot/dts/Makefile        |    3 ++-
>   arch/arm/boot/dts/bcm28155-ap.dts |   29 +++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/bcm28155-ap.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f0895c5..187f336 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -40,7 +40,8 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
>   dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
>   
>   dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
> -dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
> +dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
> +	bcm28155-ap.dtb
>   dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>   	da850-evm.dtb
>   dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
> new file mode 100644
> index 0000000..0d66db6
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm11351.dtsi"
> +
> +/ {
> +	model = "BCM28155 AP board";
> +	compatible = "bcm,bcm28155-ap", "bcm,bcm11351";
> +
> +	memory {
> +		reg = <0x80000000 0x40000000>; /* 1 GB */
> +	};
> +
> +	uart at 3e000000 {
> +		status = "okay";
> +	};
> +};
applied.
  thanks,
    csd
