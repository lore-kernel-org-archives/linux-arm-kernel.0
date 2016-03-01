From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Mar 2016 21:37:10 +0800
Subject: [PATCH 2/3] ARM: i.MX25: add RNGC node to dtsi
In-Reply-To: <1456761156-27664-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1456761156-27664-1-git-send-email-s.trumtrar@pengutronix.de>
 <1456761156-27664-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20160301133710.GV22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 04:52:35PM +0100, Steffen Trumtrar wrote:
> Add a devicetree entry for the Random Number Generator Version C (RNGC).
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx25.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index cde329e9b9e3..ec44ed125057 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -397,6 +397,15 @@
>  				interrupts = <41>;
>  			};
>  
> +			rng: rng at 53fb0000 {
> +				compatible = "fsl,imx25-rng";
> +				reg = <0x53fb0000 0x4000>;
> +				clocks = <&clks 109>;
> +				clock-names = "ipg";
> +				interrupts = <22>;
> +				interrupt-names = "rng";

I do not see interrupt-names in the binding doc (patch #1).  IMO, it
should be dropped.

Shawn

> +			};
> +
>  			esdhc1: esdhc at 53fb4000 {
>  				compatible = "fsl,imx25-esdhc";
>  				reg = <0x53fb4000 0x4000>;
> -- 
> 2.7.0
> 
> 
