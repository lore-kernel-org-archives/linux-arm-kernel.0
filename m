From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Aug 2013 09:30:36 +0800
Subject: [PATCH v2 4/7] ARM: dts: imx27 pinctrl
In-Reply-To: <1376921234-26682-5-git-send-email-mpa@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20130821013035.GB30533@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 04:07:11PM +0200, Markus Pargmann wrote:
> Pinctrl driver node and pin group definitions for other driver nodes.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 76cd89f..b9477d6 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include "imx27-pinfunc.h"
>  
>  / {
>  	aliases {
> @@ -235,6 +236,89 @@
>  				status = "disabled";
>  			};
>  
> +			iomuxc: iomuxc at 10015000 {
> +				compatible = "fsl,imx27-iomuxc";
> +				reg = <0x10015000 0x600>;
> +
> +				fec {
> +					pinctrl_fec_1: fec-1 {
> +						fsl,pins = <
> +							MX27_PAD_SD3_CMD__FEC_TXD0 0x0
> +							MX27_PAD_SD3_CLK__FEC_TXD1 0x0
> +							MX27_PAD_ATA_DATA0__FEC_TXD2 0x0
> +							MX27_PAD_ATA_DATA1__FEC_TXD3 0x0
> +							MX27_PAD_ATA_DATA2__FEC_RX_ER 0x0
> +							MX27_PAD_ATA_DATA3__FEC_RXD1 0x0
> +							MX27_PAD_ATA_DATA4__FEC_RXD2 0x0
> +							MX27_PAD_ATA_DATA5__FEC_RXD3 0x0
> +							MX27_PAD_ATA_DATA6__FEC_MDIO 0x0
> +							MX27_PAD_ATA_DATA7__FEC_MDC 0x0
> +							MX27_PAD_ATA_DATA8__FEC_CRS 0x0
> +							MX27_PAD_ATA_DATA9__FEC_TX_CLK 0x0
> +							MX27_PAD_ATA_DATA10__FEC_RXD0 0x0
> +							MX27_PAD_ATA_DATA11__FEC_RX_DV 0x0
> +							MX27_PAD_ATA_DATA12__FEC_RX_CLK 0x0
> +							MX27_PAD_ATA_DATA13__FEC_COL 0x0
> +							MX27_PAD_ATA_DATA14__FEC_TX_ER 0x0
> +							MX27_PAD_ATA_DATA15__FEC_TX_EN 0x0
> +						>;
> +					};
> +				};

I like the idea [1] from Alexander Shiyan that maintains all these
pinctrl setting entries outside the main device nodes structure.  Can
you please do that for imx27.dtsi from the beginning?

Shawn

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/260404

> +
> +				i2c {
> +					pinctrl_i2c_1: i2c-1 {
> +						fsl,pins = <
> +							MX27_PAD_I2C_DATA__I2C_DATA 0x0
> +							MX27_PAD_I2C_CLK__I2C_CLK 0x0
> +						>;
> +					};
> +
> +					pinctrl_i2c_2: i2c-2 {
> +						fsl,pins = <
> +							MX27_PAD_I2C2_SDA__I2C2_SDA 0x0
> +							MX27_PAD_I2C2_SCL__I2C2_SCL 0x0
> +						>;
> +					};
> +				};
> +
> +				owire {
> +					pinctrl_owire_1: owire-1 {
> +						fsl,pins = <
> +							MX27_PAD_RTCK__OWIRE 0x0
> +						>;
> +					};
> +				};
> +
> +				uart {
> +					pinctrl_uart_1: uart-1 {
> +						fsl,pins = <
> +							MX27_PAD_UART1_TXD__UART1_TXD 0x0
> +							MX27_PAD_UART1_RXD__UART1_RXD 0x0
> +							MX27_PAD_UART1_CTS__UART1_CTS 0x0
> +							MX27_PAD_UART1_RTS__UART1_RTS 0x0
> +						>;
> +					};
> +
> +					pinctrl_uart_2: uart-2 {
> +						fsl,pins = <
> +							MX27_PAD_UART2_TXD__UART2_TXD 0x0
> +							MX27_PAD_UART2_RXD__UART2_RXD 0x0
> +							MX27_PAD_UART2_CTS__UART2_CTS 0x0
> +							MX27_PAD_UART2_RTS__UART2_RTS 0x0
> +						>;
> +					};
> +
> +					pinctrl_uart_3: uart-3 {
> +						fsl,pins = <
> +							MX27_PAD_UART3_TXD__UART3_TXD 0x0
> +							MX27_PAD_UART3_RXD__UART3_RXD 0x0
> +							MX27_PAD_UART3_CTS__UART3_CTS 0x0
> +							MX27_PAD_UART3_RTS__UART3_RTS 0x0
> +						>;
> +					};
> +				};
> +			};
> +
>  			gpio1: gpio at 10015000 {
>  				compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
>  				reg = <0x10015000 0x100>;
> -- 
> 1.8.4.rc3
> 
