From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Nov 2015 22:41:45 -0800
Subject: [PATCH] ARM: dts: vfxxx: Include support for dspi[23]
 functionality.
In-Reply-To: <1447905280-5172-2-git-send-email-cory.tusar@pid1solutions.com>
References: <1447905280-5172-2-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <eefcbf4a3e7d3477546b3b8a97eb9c22@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Verified too, looks good to me.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

On 2015-11-18 19:54, Cory Tusar wrote:
> Extend the existing Vybrid DSPI devicetree implementation to also
> describe the dspi2 and dspi3 functional blocks.
> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 1cca43a..858e60a 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -453,6 +453,30 @@
>  				status = "disabled";
>  			};
>  
> +			dspi2: dspi2 at 400ac000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,vf610-dspi";
> +				reg = <0x400ac000 0x1000>;
> +				interrupts = <69 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_DSPI2>;
> +				clock-names = "dspi";
> +				spi-num-chipselects = <2>;
> +				status = "disabled";
> +			};
> +
> +			dspi3: dspi3 at 400ad000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,vf610-dspi";
> +				reg = <0x400ad000 0x1000>;
> +				interrupts = <70 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_DSPI3>;
> +				clock-names = "dspi";
> +				spi-num-chipselects = <2>;
> +				status = "disabled";
> +			};
> +
>  			adc1: adc at 400bb000 {
>  				compatible = "fsl,vf610-adc";
>  				reg = <0x400bb000 0x1000>;
