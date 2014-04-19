From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 19 Apr 2014 13:34:15 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl-sabresd: Add HDMI support
In-Reply-To: <1397825219-7872-1-git-send-email-festevam@gmail.com>
References: <1397825219-7872-1-git-send-email-festevam@gmail.com>
Message-ID: <20140419053413.GU2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:46:59AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> I currently do not have hardware access, so I did not test this one.
> 
> It is based on the previous version that I submitted and tested.

Please retest it against my for-next branch.

> 
> Changes since v1:
> - Rebased against 3.15-rc1
> 
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 7a88d9a..3d88712 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -148,6 +148,14 @@
>  	status = "okay";
>  };
>  
> +&hdmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	ddc-i2c-bus = <&i2c2>;
> +	status = "okay";
> +	crtcs = <&ipu1 1>;

The 'crtcs' property should be dropped now.

> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -390,6 +398,13 @@
>  			>;
>  		};
>  
> +
> +		pinctrl_hdmi: hdmigrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0

Is this only needed by CEC support?  And is the imx-hdmi driver already
support CEC?

Shawn

> +			>;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
> -- 
> 1.8.3.2
> 
> 
> 
