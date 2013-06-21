From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 10:44:08 +0800
Subject: [PATCH 5/6] ARM: dts: imx27 cpufreq-cpu0 frequencies
In-Reply-To: <1371739815-6666-6-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130621024406.GB24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 04:50:14PM +0200, Markus Pargmann wrote:
> Set operating-points for imx27. There is no regulator support, so the
> voltages are 0. The frequencies should be the same for all imx27 boards,
> so it is defined here and can be overwritten if necessary.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index e883e77..3ebd98a 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -47,6 +47,25 @@
>  		};
>  	};
>  
> +	cpus {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "fsl,imx27", "arm,arm926ejs";

>From what Documentation/devicetree/bindings/arm/cpus.txt tells, it
should be "arm,arm926".  Also, why do you put "fsl,imx27" there?
"imx27" is a SoC name not cpu core.

Shawn

> +			reg = <0>;
> +			operating-points = <
> +				/* kHz  uV (No regulator support) */
> +				133000  0
> +				399000  0
> +			>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks 18>;
> +			clock-names = "cpu";
> +		};
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 1.8.2.1
> 
