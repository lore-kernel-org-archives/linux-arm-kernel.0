From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 05 Feb 2018 12:21:13 +0100
Subject: [PATCH 1/2] arm64: dts: fsl: imx8mq: add watchdog devices
In-Reply-To: <4c7c9104ca95419d22b8df19a69819e194dd3488.1517816731.git.baruch@tkos.co.il>
References: <4c7c9104ca95419d22b8df19a69819e194dd3488.1517816731.git.baruch@tkos.co.il>
Message-ID: <1517829673.3175.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 05.02.2018, 09:45 +0200 schrieb Baruch Siach:
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> ?arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
> ?1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 50ed302d299a..740457e2a0bf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -250,6 +250,30 @@
> > ?				??????????????"clk_ext1", "clk_ext2",
> > ?				??????????????"clk_ext3", "clk_ext4";
> > ?			};
> +
> +			wdog1: wdog at 30280000 {

watchdog@, please.

Otherwise looks good to me, so with this fixed:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de

> +				compatible = "fsl,imx21-wdt";
> > +				reg = <0x30280000 0x10000>;
> > +				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_WDOG1_ROOT>;
> > +				status = "disabled";
> > +			};
> +
> > > +			wdog2: wdog at 30290000 {
> > +				compatible = "fsl,imx21-wdt";
> > +				reg = <0x30290000 0x10000>;
> > +				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_WDOG2_ROOT>;
> > +				status = "disabled";
> > +			};
> +
> > > +			wdog3: wdog at 302a0000 {
> > +				compatible = "fsl,imx21-wdt";
> > +				reg = <0x302a0000 0x10000>;
> > +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
> > +				status = "disabled";
> > +			};
> > ?		};
> ?
> > ?		bus at 30400000 { /* AIPS2 */
