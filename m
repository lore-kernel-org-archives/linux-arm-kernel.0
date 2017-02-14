From: w.egorov@phytec.de (Wadim Egorov)
Date: Tue, 14 Feb 2017 15:12:37 +0100
Subject: [PATCH V3 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <1487066851-25142-3-git-send-email-eddie.cai.linux@gmail.com>
References: <1487066851-25142-1-git-send-email-eddie.cai.linux@gmail.com>
 <1487066851-25142-3-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <e555144a-b698-1fad-c377-8af2fd8697c5@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,


On 14.02.2017 11:07, Eddie Cai wrote:
> This patch add basic support for RK3288-Tinker board. We can boot in to rootfs
> with this patch.
>
> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/rk3288-tinker.dts | 536 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 537 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-tinker.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 01d178a..0dfef24 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -679,6 +679,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-popmetal.dtb \
>  	rk3288-r89.dtb \
>  	rk3288-rock2-square.dtb \
> +	rk3288-tinker.dtb \
>  	rk3288-veyron-brain.dtb \
>  	rk3288-veyron-jaq.dtb \
>  	rk3288-veyron-jerry.dtb \
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dts b/arch/arm/boot/dts/rk3288-tinker.dts
> new file mode 100644
> index 0000000..9600d1f
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-tinker.dts
> @@ -0,0 +1,536 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include "rk3288.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Rockchip RK3288 Tinker Board";
> +	compatible = "asus,rk3288-tinker", "rockchip,rk3288";
> +
> +	memory {
> +		reg = <0x0 0x80000000>;
> +		device_type = "memory";
> +	};
> +
> +	ext_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn>;
> +
> +		button at 0 {
> +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			label = "GPIO Key Power";
> +			linux,input-type = <1>;
> +			gpio-key,wakeup = <1>;

you should replace this with wakeup-source as specified in
Documentation/devicetree/bindings/power/wakeup-source.txt

Regards,
Wadim
