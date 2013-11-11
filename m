From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 15:57:27 +0800
Subject: [PATCH 1/2] ARM: dts: i.MX27: Add SSI nodes
In-Reply-To: <1384069921-15270-1-git-send-email-shc_work@mail.ru>
References: <1384069921-15270-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131111075726.GG10085@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 10, 2013 at 11:52:00AM +0400, Alexander Shiyan wrote:
> This patch adds the missing (Synchronous Serial Interface) SSI1 & SSI2
> devicetree nodes for i.MX27 CPUs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 826231e..52520fb 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -204,6 +204,30 @@
>  				status = "disabled";
>  			};
>  
> +			ssi1: ssi at 10010000 {
> +				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
> +				reg = <0x10010000 0x1000>;
> +				interrupts = <14>;
> +				clocks = <&clks 26>;
> +				dmas = <&dma 12>, <&dma 13>;
> +				dma-names = "rx", "tx";
> +				fsl,fifo-depth = <8>;
> +				fsl,ssi-dma-events = <13 12 15 14>; /* TX0 RX0 TX1 RX1 */

This custom property is deprecated and shouldn't be needed now.

Shawn

> +				status = "disabled";
> +			};
> +
> +			ssi2: ssi at 10011000 {
> +				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
> +				reg = <0x10011000 0x1000>;
> +				interrupts = <13>;
> +				clocks = <&clks 25>;
> +				dmas = <&dma 8>, <&dma 9>;
> +				dma-names = "rx", "tx";
> +				fsl,fifo-depth = <8>;
> +				fsl,ssi-dma-events = <9 8 11 10>; /* TX0 RX0 TX1 RX1 */
> +				status = "disabled";
> +			};
> +
>  			i2c1: i2c at 10012000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -- 
> 1.8.1.5
> 
