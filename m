From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 2 Apr 2016 09:29:55 +0800
Subject: [PATCH v2 1/9] ARM: dts: imx7d: add lcdif support
In-Reply-To: <1458050668-26748-2-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-2-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <20160402012955.GI18833@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 03:04:20PM +0100, Gary Bisson wrote:
> Add the device node for the i.MX7 eLCDIF interface.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> 
> Changelog v1 -> v2:
> - none
> 
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index b5a50e0..a768716 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -608,6 +608,17 @@
>  				status = "disabled";
>  			};
>  
> +			lcdif: lcdif at 30730000 {

Please add the node in order of unit-address.

Shawn

> +				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
> +				reg = <0x30730000 0x10000>;
> +				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
> +					<&clks IMX7D_CLK_DUMMY>,
> +					<&clks IMX7D_CLK_DUMMY>;
> +				clock-names = "pix", "axi", "disp_axi";
> +				status = "disabled";
> +			};
> +
>  			pwm1: pwm at 30660000 {
>  				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
>  				reg = <0x30660000 0x10000>;
> -- 
> 2.7.0
> 
> 
