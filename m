From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Oct 2018 14:05:03 +0800
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4
In-Reply-To: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
References: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
Message-ID: <20181008060500.GI3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a few udoo board users for comment.

On Thu, Oct 04, 2018 at 04:33:59PM +0200, Markus Kueffner wrote:
> From: Markus Kueffner <kueffner.markus@gmail.com>
> 
> Add Pincfgs for UART4 to enable Communication with the onboard SAM3X
> 
> Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index 4f27861..5614170 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -195,6 +195,13 @@
>  			>;
>  		};
>  
> +		pinctrl_uart4: uart4grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
> +				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
> +			>;
> +		};
> +
>  		pinctrl_usbh: usbhgrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x80000000
> @@ -265,6 +272,12 @@
>  	status = "okay";
>  };
>  
> +&uart4 { // iMX6-Arduino internal serial port - ttymxc3
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
>  &usbh1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbh>;
> -- 
> 2.7.4
> 
