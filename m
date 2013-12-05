From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Dec 2013 21:56:50 +0100
Subject: [PATCHv5][ 6/8] ARM: dts: mbimx51sd: Add display support.
In-Reply-To: <1386268092-21719-6-git-send-email-denis@eukrea.com>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-6-git-send-email-denis@eukrea.com>
Message-ID: <201312052156.50236.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 05, 2013 at 07:28:10 PM, Denis Carikli wrote:
> The CMO-QVGA, DVI-SVGA and DVI-VGA are added.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v3->v5:
> - Updated to new GPIO defines.
> - Updated to new licenses checkpatch requirements.
> - one whitespace cleanup.
> 
> ChangeLog v2->v3:
> - Splitted out from the patch that added support for the cpuimx51/mbimxsd51
> boards. - This patch now only adds display support.
> - Added some interested people in the Cc list, and removed some people that
>   might be annoyed by the receiving of that patch which is unrelated to
> their subsystem.
> - rebased and reworked the dts displays addition.
> - Also rebased and reworked the fsl,pins usage.
> ---
>  .../imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts  |   55
> ++++++++++++++++++++ .../imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts  | 
>  42 +++++++++++++++ .../imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts   |  
> 42 +++++++++++++++ .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  
> 13 +++++
>  4 files changed, 152 insertions(+)
>  create mode 100644
> arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts create
> mode 100644
> arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts create
> mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
> 
> diff --git
> a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
> b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts new file
> mode 100644
> index 0000000..f37d65b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "imx51-eukrea-mbimxsd51-baseboard.dts"
> +
> +/ {
> +	model = "Eukrea MBIMXSD51 with the CMO-QVGA Display";
> +	compatible = "eukrea,mbimxsd51-baseboard-cmo-qvga",
> "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51"; +
> +	reg_lcd_3v3: lcd-en {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
> +		regulator-name = "lcd-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&display {
> +	display-supply = <&reg_lcd_3v3>;
> +	status = "okay";

The "status = " here should probably be in the board DTS, not in the LCD DTS.

> +	display-timings {
> +		model = "CMO-QVGA";
> +		bits-per-pixel = <16>;
> +		cmoqvga {
> +			native-mode;
> +			clock-frequency = <6500000>;
> +			hactive = <320>;
> +			vactive = <240>;
> +			hfront-porch = <20>;
> +			hback-porch = <38>;
> +			vfront-porch = <4>;
> +			vback-porch = <15>;
> +			hsync-len = <30>;
> +			vsync-len = <3>;
> +			hsync-active = <0>;
> +			vsync-active = <0>;
> +			de-active = <0>;
> +			pixelclk-active = <1>;
> +		};
> +	};
> +};

[...]
