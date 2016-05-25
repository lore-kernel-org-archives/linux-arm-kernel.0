From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 14:08:29 -0500
Subject: [PATCH 2/2] ARM: at91: Add DT support for Olimex SAM9-L9260 board.
In-Reply-To: <1464164106-28359-2-git-send-email-raashidmuhammed@zilogic.com>
References: <1464164106-28359-1-git-send-email-raashidmuhammed@zilogic.com>
 <1464164106-28359-2-git-send-email-raashidmuhammed@zilogic.com>
Message-ID: <20160525190828.GA22435@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 01:45:06PM +0530, Raashid Muhammed wrote:
> From: Raashid Muhammed <raashidmuhammed@zilogic.com>
> 
> sam9-l9260 is a low cost board designed by Olimex.
> 
> More information is available at:
> https://www.olimex.com/Products/ARM/Atmel/SAM9-L9260/
> 
> Signed-off-by: Raashid Muhammed <raashidmuhammed@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@bravegnu.org>
> ---
>  Documentation/devicetree/bindings/arm/olimex.txt |   8 +-
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/at91-sam9_l9260.dts            | 115 +++++++++++++++++++++++
>  3 files changed, 122 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91-sam9_l9260.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/olimex.txt b/Documentation/devicetree/bindings/arm/olimex.txt
> index 007fb5c..d726aec 100644
> --- a/Documentation/devicetree/bindings/arm/olimex.txt
> +++ b/Documentation/devicetree/bindings/arm/olimex.txt
> @@ -1,5 +1,9 @@
> -Olimex i.MX Platforms Device Tree Bindings
> -------------------------------------------
> +Olimex Device Tree Bindings
> +---------------------------
> +
> +SAM9-L9260 Board
> +Required root node properties:
> +    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
>  
>  i.MX23 Olinuxino Low Cost Board
>  Required root node properties:
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0f89d87..d27f09d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
>  	usb_a9260.dtb \
>  	at91sam9261ek.dtb \
>  	at91sam9263ek.dtb \
> +	at91-sam9_l9260.dtb \
>  	tny_a9263.dtb \
>  	usb_a9263.dtb \
>  	at91-foxg20.dtb \
> diff --git a/arch/arm/boot/dts/at91-sam9_l9260.dts b/arch/arm/boot/dts/at91-sam9_l9260.dts
> new file mode 100644
> index 0000000..e2da9b906
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sam9_l9260.dts
> @@ -0,0 +1,115 @@
> +/*
> + * at91-sam9_l9260.dts - Device Tree file for Olimex SAM9-L9260 board
> + *
> + *  Copyright (C) 2016 Raashid Muhammed <raashidmuhammed@zilogic.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +/dts-v1/;
> +#include "at91sam9260.dtsi"
> +
> +/ {
> +	model = "Olimex sam9-l9260";
> +	compatible = "olimex,sam9-l9260", "atmel,at91sam9260", "atmel,at91sam9";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	 };
> +
> +	 memory {
> +		reg = <0x20000000 0x4000000>;
> +	 };
> +
> +	 clocks {
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <18432000>;
> +		};
> +	 };
> +
> +	 ahb {

The whitespace is off here and throughout. You've got a <tab><space>...

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
