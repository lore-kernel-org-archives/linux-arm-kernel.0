From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 23:25:17 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1436796692-8875-1-git-send-email-fabio.estevam@freescale.com>
References: <1436796692-8875-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150713152517.GE26642@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 11:11:32AM -0300, Fabio Estevam wrote:
> Currently it is not possible to have HDMI and LVDS working simultaneously,
> because both ports try to use PLL5.
> 
> Move the LVDS clock parent to PLL3_USB_OTG, so that HDMI and LVDS can be
> driven from independent sources.
> 
> With this change the LDB pixel clock goes to 68.57 MHz, which is still
> within the valid range for the HSD100PXN1 LVDS panel.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Rebased against latest imx/dt branch
> 
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 6b17b85..2030de8 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -99,6 +99,13 @@
>  	assigned-clock-rates = <0>, <0>, <24576000>;
>  };
>  
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +

There is already an assigned-clocks in &clks added by audio support.

Shawn

>  &ecspi1 {
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio3 19 0>;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
