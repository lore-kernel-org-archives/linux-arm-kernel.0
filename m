From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 05:34:19 +0800
Subject: [PATCH] ARM: dts: mxs: Add the second I2C adapter to the
 CFA10049 expansion board
In-Reply-To: <1346169744-24674-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1346169744-24674-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120830213417.GB3613@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 06:02:24PM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx28-cfa10049.dts |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-cfa10049.dts

Please add the dtb target into arch/arm/mach-mxs/Makefile.boot.

Regards,
Shawn

> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> new file mode 100644
> index 0000000..e0e4b8c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -0,0 +1,31 @@
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
> +/*
> + * The CFA-10049 is an expansion board for the CFA-10036 module, thus we
> + * need to include the CFA-10036 DTS.
> + */
> +/include/ "imx28-cfa10036.dts"
> +
> +/ {
> +	model = "Crystalfontz CFA-10049 Board";
> +	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
> +
> +	apb at 80000000 {
> +		apbx at 80040000 {
> +			i2c1: i2c at 8005a000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c1_pins_a>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.9.5
> 
