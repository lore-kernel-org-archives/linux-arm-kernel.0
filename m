From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 29 Jun 2015 20:14:05 +0200
Subject: [PATCH 1/3] ARM: dts: imx6qdl-sabrelite: Allow HDMI and LVDS to
 work simultaneously
In-Reply-To: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
References: <1435594615-9570-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAAMH-yu=C=haGN33r0p3sxsqT97Emq3Ge2pyfYRMSmEU7LYBSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio, all,

On Mon, Jun 29, 2015 at 6:16 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
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
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> index e00c44f..d87e71c 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> @@ -148,6 +148,13 @@
>         status = "okay";
>  };
>
> +&clks {
> +       assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> +                         <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> +       assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
> +                                <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
> +};
> +
>  &ecspi1 {
>         fsl,spi-num-chipselects = <1>;
>         cs-gpios = <&gpio3 19 0>;
> --
> 1.9.1
>

Tested using linux-next 20150629 on Sabrelite with either Hannstar 7"
or 10" + HDMI monitor.
This patch relies on previous clk-imx6q patch from Fabio:
https://patchwork.kernel.org/patch/6682561/

Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>

Regards,
Gary
