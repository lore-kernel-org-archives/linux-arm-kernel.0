From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 13 Jan 2016 10:40:36 +0100
Subject: [PATCH 08/14] ARM: dts: imx6ul: add kpp support
In-Reply-To: <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452678036.3694.51.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 12.01.2016, 18:21 +0100 schrieb Lothar Wa?mann:
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 40ea5f0..a578b23 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -373,6 +373,14 @@
>  				status = "disabled";
>  			};
>  
> +			kpp: kpp at 020b8000 {
> +				compatible = "fsl,imx6q-kpp", "fsl,imx21-kpp";

Please always add a new chip specific compatible here, even if the units
are fully working with the compatible of an older chip. This allows to
implement chip specific workarounds in the respective drivers without
changing the DT again if any bugs are found in the integration later on.

So the above should be:
compatible = "fsl,imx6ul-kpp", "fsl,imx6q-kpp", "fsl,imx21-kpp";

This comment applies to most of the patches in this series following
this one.

Regards,
Lucas

> +				reg = <0x020b8000 0x4000>;
> +				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_KPP>;
> +				status = "disabled";
> +			};
> +
>  			wdog1: wdog at 020bc000 {
>  				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
>  				reg = <0x020bc000 0x4000>;

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
