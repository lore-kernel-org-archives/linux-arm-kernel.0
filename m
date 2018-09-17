From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:14 -0400
Subject: [PATCH] arm64: dts: rockchip: add initial dts support for
 Rockpro64 board
In-Reply-To: <1536926957-12432-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
 <1536926957-12432-1-git-send-email-Akash_Gajjar@mentor.com>
Message-ID: <20180917054414.GA13346@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 05:39:09PM +0530, Akash Gajjar wrote:
> Rockpro64 board is a rockchip RK3399 based board from pine64.org.
> This commit adds initial device tree support for Rockpro64 board.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 770 +++++++++++++++++++++
>  3 files changed, 775 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index acfd3c7..ac95183 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -160,6 +160,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>      - compatible = "pine64,rock64", "rockchip,rk3328";
>  
> +- Pine64 RockPro64 board:
> +    Required root node properties:
> +    - compatible = "pine64,rockpro64", "rockchip,rk3399";
> +
>  - Rockchip PX3 Evaluation board:
>      Required root node properties:
>        - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b0092d9..03d523a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> new file mode 100644
> index 0000000..9e2d4d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -0,0 +1,770 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 RockPro64";
> +	compatible = "pine64,rockpro64", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm0 0 25000 0>;
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7
> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23

There's a binding now so you don't have to list every single entry.

Rob
