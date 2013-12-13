From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Dec 2013 12:47:49 +0100
Subject: [PATCH V1 04/11] ARM: dts: imx6qdl-sabrelite: add comments for
 pinctrl_hog
In-Reply-To: <1386899355-17379-5-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-5-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <201312131247.49776.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 at 02:49:08 AM, Troy Kisky wrote:
> Add a comment to tell the purpose of each pin. This
> makes it easy to tell if it should go somewhere else.
> i.e. the spi-nor cs could be put with pinctrl_ecspi1.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi index c4aa504..be899d3 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -114,13 +114,13 @@
>  	imx6q-sabrelite {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
> -				MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x80000000
> -				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000
> -				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
> -				MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000
> -				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x80000000
> -				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0
> -				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
> +/* uSDHC4 CD  */		MX6QDL_PAD_NANDF_D6__GPIO2_IO06	0x80000000
> +/* spi-nor CS */		MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x80000000
> +/* otg power en */		MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x80000000
> +/* ethernet phy reset */	MX6QDL_PAD_EIM_D23__GPIO3_IO23	0x80000000
> +/* USDHC3 CD  */		MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x80000000
> +/* USDHC3 WP  */		MX6QDL_PAD_SD3_DAT4__GPIO7_IO01	0x1f0b0
> +/* SGTL5000 sys_mclk  */	MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x80000000

Can you please place the comments past the pin instead of in front of it? If 
they don't fit, place the comment above the pin then.

Placing the comment before the pin name seems really strange to me.

Best regards,
Marek Vasut
