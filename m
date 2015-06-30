From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 30 Jun 2015 11:41:59 +0200
Subject: [PATCH 2/3] ARM: dts: imx6qdl-nitrogen6x: Allow HDMI and LVDS
 to work simultaneously
In-Reply-To: <1435594615-9570-2-git-send-email-fabio.estevam@freescale.com>
References: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
 <1435594615-9570-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1435657319.13470.20.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 29.06.2015, 13:16 -0300 schrieb Fabio Estevam:
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
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index 3af16df..1cba390 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -149,6 +149,13 @@
>  	status = "okay";
>  };
>  
> +&clks {
> +	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
with a HannStar HSD070PWW1 7" 1280x800 panel (results in 58.93 Hz
vrefresh with the default timings).

regards
Philipp
