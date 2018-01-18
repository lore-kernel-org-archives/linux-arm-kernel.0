From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 18 Jan 2018 02:06:58 +0100
Subject: [PATCH v2 07/16] ARM: dts: r8a7791: sort subnodes of root node
In-Reply-To: <20180117161717.14589-8-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-8-horms+renesas@verge.net.au>
Message-ID: <20180118010658.GG11924@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for your work.

On 2018-01-17 17:17:08 +0100, Simon Horman wrote:
> Sort subnodes of root node to aid maintenance.
> 
> This patch should not introduce any functional change.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2
> * New patch
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 134 ++++++++++++++++++++---------------------
>  1 file changed, 67 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index de2af2199731..dc659351472f 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -39,6 +39,35 @@
>  		vin2 = &vin2;
>  	};
>  
> +	/*
> +	 * The external audio clocks are configured as 0 Hz fixed frequency
> +	 * clocks by default.
> +	 * Boards that provide audio clocks should override them.
> +	 */
> +	audio_clk_a: audio_clk_a {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +	audio_clk_b: audio_clk_b {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +	audio_clk_c: audio_clk_c {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	/* External CAN clock */
> +	can_clk: can {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board. */
> +		clock-frequency = <0>;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -82,23 +111,27 @@
>  		};
>  	};
>  
> -	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> -			polling-delay-passive	= <0>;
> -			polling-delay		= <0>;
> +	/* External root clock */
> +	extal_clk: extal {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board. */
> +		clock-frequency = <0>;
> +	};
>  
> -			thermal-sensors = <&thermal>;
> +	/* External PCIe clock - can be overridden by the board */
> +	pcie_bus_clk: pcie_bus {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
>  
> -			trips {
> -				cpu-crit {
> -					temperature	= <95000>;
> -					hysteresis	= <0>;
> -					type		= "critical";
> -				};
> -			};
> -			cooling-maps {
> -			};
> -		};
> +	/* External SCIF clock */
> +	scif_clk: scif {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board. */
> +		clock-frequency = <0>;
>  	};
>  
>  	soc {
> @@ -1668,6 +1701,25 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive	= <0>;
> +			polling-delay		= <0>;
> +
> +			thermal-sensors = <&thermal>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature	= <95000>;
> +					hysteresis	= <0>;
> +					type		= "critical";
> +				};
> +			};
> +			cooling-maps {
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> @@ -1676,62 +1728,10 @@
>  				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
>  
> -	/* External root clock */
> -	extal_clk: extal {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		/* This value must be overridden by the board. */
> -		clock-frequency = <0>;
> -	};
> -
> -	/*
> -	 * The external audio clocks are configured as 0 Hz fixed frequency
> -	 * clocks by default.
> -	 * Boards that provide audio clocks should override them.
> -	 */
> -	audio_clk_a: audio_clk_a {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <0>;
> -	};
> -	audio_clk_b: audio_clk_b {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <0>;
> -	};
> -	audio_clk_c: audio_clk_c {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <0>;
> -	};
> -
> -	/* External PCIe clock - can be overridden by the board */
> -	pcie_bus_clk: pcie_bus {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <0>;
> -	};
> -
> -	/* External SCIF clock */
> -	scif_clk: scif {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		/* This value must be overridden by the board. */
> -		clock-frequency = <0>;
> -	};
> -
>  	/* External USB clock - can be overridden by the board */
>  	usb_extal_clk: usb_extal {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
>  		clock-frequency = <48000000>;
>  	};
> -
> -	/* External CAN clock */
> -	can_clk: can {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		/* This value must be overridden by the board. */
> -		clock-frequency = <0>;
> -	};
>  };
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas S?derlund
