From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:09:36 -0500
Subject: [PATCH v2 22/22] ARM: dts: exynos: Add initial support for
 Odroid XU board
In-Reply-To: <1462734367-5619-23-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-23-git-send-email-krzk@kernel.org>
Message-ID: <20160509200936.GA24252@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2016 at 09:06:07PM +0200, Krzysztof Kozlowski wrote:
> The Hardkernel's Odroid XU board was first design with big.LITTLE SoC
> from Samsung: the Exynos5410. Comparing now to more popular Odroid XU3
> the differences are:
> 1. Exynos5410 instead of 5422,
> 2. DisplayPort,
> 3. Main PMIC: Maxim 77802 instead of S2MPS11,
> 4. USB3503+LAN9730 instead of integrated LAN9514,
> 5. eMMC 4.5 instead of eMMC 5.0,
> 
> This patch adds initial support for the XU board with working basic
> functions, eMMC/SD and USB (including attached ethernet adapter).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          | 166 +++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index f5deace2b380..0ea7f14ef294 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -47,6 +47,7 @@ Required root node properties:
>  	- "hardkernel,odroid-u3"  - for Exynos4412-based Hardkernel Odroid U3.
>  	- "hardkernel,odroid-x"   - for Exynos4412-based Hardkernel Odroid X.
>  	- "hardkernel,odroid-x2"  - for Exynos4412-based Hardkernel Odroid X2.
> +	- "hardkernel,odroid-xu"  - for Exynos5410-based Hardkernel Odroid XU.
>  	- "hardkernel,odroid-xu3" - for Exynos5422-based Hardkernel Odroid XU3.
>  	- "hardkernel,odroid-xu3-lite" - for Exynos5422-based Hardkernel
>  					 Odroid XU3 Lite board.
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5aeb10674370..9ed1c7abedb1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -134,6 +134,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5250-snow-rev5.dtb \
>  	exynos5250-spring.dtb \
>  	exynos5260-xyref5260.dtb \
> +	exynos5410-odroidxu.dtb \
>  	exynos5410-smdk5410.dtb \
>  	exynos5420-arndale-octa.dtb \
>  	exynos5420-peach-pit.dtb \
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> new file mode 100644
> index 000000000000..b0cbd53aeea9
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -0,0 +1,166 @@
> +/*
> + * Hardkernel Odroid XU3 board device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Copyright (c) 2016 Krzysztof Kozlowski
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "exynos5410.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "exynos54xx-odroidxu-leds.dtsi"
> +
> +/ {
> +	model = "Hardkernel Odroid XU";
> +	compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
> +
> +	memory {
> +		reg = <0x40000000 0x7EA00000>;

lowercase hex please.

With that,

Acked-by: Rob Herring <robh@kernel.org>
