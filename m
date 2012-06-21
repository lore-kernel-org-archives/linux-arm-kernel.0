From: marex@denx.de (Marek Vasut)
Date: Thu, 21 Jun 2012 11:49:01 +0200
Subject: [PATCH 2/2] ARM: MXS: Add Crystalfontz CFA-10036 DTS
In-Reply-To: <1340268415-5022-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340268415-5022-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201206211149.01556.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Brian Lily <brian@crystalfontz.com>

But then, wait ... why did you add the mach-cfa10036.c entry?

> ---
>  arch/arm/boot/dts/cfa10036.dts |   66
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 66 insertions(+)
>  create mode 100644 arch/arm/boot/dts/cfa10036.dts
> 
> diff --git a/arch/arm/boot/dts/cfa10036.dts
> b/arch/arm/boot/dts/cfa10036.dts new file mode 100644
> index 0000000..ceae960
> --- /dev/null
> +++ b/arch/arm/boot/dts/cfa10036.dts
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright 2012 Free Electrons
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx28.dtsi"
> +
> +/ {
> +	model = "Crystalfontz CFA-10036 Board";
> +	compatible = "crystalfontz,cfa10036", "fsl,imx28-evk", "fsl,imx28";
> +
> +	memory {
> +		reg = <0x40000000 0x08000000>;
> +	};
> +
> +	apb at 80000000 {
> +		apbh at 80000000 {
> +			ssp0: ssp at 80010000 {
> +				compatible = "fsl,imx28-mmc";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&mmc0_4bit_pins_a
> +					&mmc0_cd_cfg &mmc0_sck_cfg>;
> +				bus-width = <4>;
> +				status = "okay";
> +			};
> +			pinctrl at 80018000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx28-pinctrl", "simple-bus";
> +				reg = <0x80018000 2000>;
> +
> +				mmc0_4bit_pins_a: mmc0-4bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x2000 0x2010 0x2020
> +						0x2030 0x2080 0x2090 0x20a0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;

Do you need this copy here?

> +				};
> +
> +				duart_pins_a: duart at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3022 0x3032>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;

And this?

> +				};
> +			};
> +		};
> +
> +		apbx at 80040000 {
> +			duart: serial at 80074000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&duart_pins_a>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};

Best regards,
Marek Vasut
