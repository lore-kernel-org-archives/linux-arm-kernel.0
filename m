From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 23 Feb 2017 13:27:24 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <20170223104025.5755-1-zajec5@gmail.com>
References: <20170223104025.5755-1-zajec5@gmail.com>
Message-ID: <bd36df47-cefe-5736-e02c-621a21ae1b7a@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

As discussed for other platforms as well, please use the board's name as 
the same board can end up being sold under multiple model numbers.

So please rename the file to bcm47094-linksys-panamera.dts


Best,

Imre


On 2017-02-23 11:40, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> It's tri-band wireless home router based on BCM47094 AKA BCM4709C0. It
> uses 3 x BCM4366 chipsets for wireless.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/bcm47094-linksys-ea9500.dts | 36 +++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm47094-linksys-ea9500.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 52a05289c538..931db0b41246 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -93,6 +93,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>  	bcm4709-netgear-r8000.dtb \
>  	bcm4709-tplink-archer-c9-v1.dtb \
>  	bcm47094-dlink-dir-885l.dtb \
> +	bcm47094-linksys-ea9500.dtb \
>  	bcm47094-luxul-xwr-3100.dtb \
>  	bcm47094-netgear-r8500.dtb \
>  	bcm94708.dtb \
> diff --git a/arch/arm/boot/dts/bcm47094-linksys-ea9500.dts b/arch/arm/boot/dts/bcm47094-linksys-ea9500.dts
> new file mode 100644
> index 000000000000..31639e5b8c72
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm47094-linksys-ea9500.dts
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2017 Rafa? Mi?ecki <rafal@milecki.pl>
> + *
> + * Licensed under the ISC license.
> + */
> +
> +/dts-v1/;
> +
> +#include "bcm47094.dtsi"
> +#include "bcm5301x-nand-cs0-bch8.dtsi"
> +
> +/ {
> +	compatible = "linksys,ea9500", "brcm,bcm47094", "brcm,bcm4708";
> +	model = "Linksys EA9500";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	memory {
> +		reg = <0x00000000 0x08000000
> +		       0x88000000 0x08000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		wps {
> +			label = "WPS";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
>
