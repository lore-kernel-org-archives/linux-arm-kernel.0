From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Jun 2017 11:38:52 +0800
Subject: [PATCH 1/2] RFC: ARM: dts: imx7d-sdb: remove 100k pull-down on
 USDHCx clock
In-Reply-To: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1496857542-32200-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20170615033851.GA5902@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 10:45:41AM -0700, Troy Kisky wrote:
> No i.mx6q board uses a 100k pull-down on clock, why should i.mx7d ?
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Add Dong and Frank who may help to confirm.

Shawn

> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 54c4540..cab9208 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -591,7 +591,7 @@
>  		pinctrl_usdhc1: usdhc1grp {
>  			fsl,pins = <
>  				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> -				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x09
>  				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
>  				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
>  				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> @@ -605,7 +605,7 @@
>  		pinctrl_usdhc2: usdhc2grp {
>  			fsl,pins = <
>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x59
> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x19
> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x09
>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
> @@ -616,7 +616,7 @@
>  		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
>  			fsl,pins = <
>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x0a
>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
> @@ -627,7 +627,7 @@
>  		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
>  			fsl,pins = <
>  				MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
> -				MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
> +				MX7D_PAD_SD2_CLK__SD2_CLK		0x0b
>  				MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
> @@ -639,7 +639,7 @@
>  		pinctrl_usdhc3: usdhc3grp {
>  			fsl,pins = <
>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x19
> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x09
>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
> @@ -655,7 +655,7 @@
>  		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
>  			fsl,pins = <
>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x0a
>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
> @@ -671,7 +671,7 @@
>  		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
>  			fsl,pins = <
>  				MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
> -				MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x0b
>  				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
>  				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
>  				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
