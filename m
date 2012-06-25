From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Jun 2012 23:58:39 +0800
Subject: [PATCH 2/2] ARM: MXS: Add Crystalfontz CFA-10036 DTS
In-Reply-To: <1340356494-24664-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340356494-24664-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120625155837.GE2342@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 11:14:54AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Brian Lily <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/cfa10036.dts |   43 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 arch/arm/boot/dts/cfa10036.dts
> 
> diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/cfa10036.dts
> new file mode 100644
> index 0000000..28b9326
> --- /dev/null
> +++ b/arch/arm/boot/dts/cfa10036.dts
> @@ -0,0 +1,43 @@
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
> +	compatible = "crystalfontz,cfa10036", "fsl,imx28";

I would like to maintain a explicit list of in-tree boards that imx28
DT machine supports, so please have the compatible string added into
imx28_dt_compat.

Regards,
Shawn

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
> +		};
> +
> +		apbx at 80040000 {
> +			duart: serial at 80074000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&duart_pins_b>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.9.5
> 
