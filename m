From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 15:01:43 -0700
Subject: [PATCH] ARM: DTS: dra7xx-clocks: Add gate clock for CLKOUT2
In-Reply-To: <1424957963-15418-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424957963-15418-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150316220143.GL12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150226 05:43]:
> To be able to control the gate for the clkout2 clock output.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Applying into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/dra7xx-clocks.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 4bdcbd61ce47..2a9994f73974 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1421,6 +1421,14 @@
>  		ti,dividers = <1>, <8>;
>  	};
>  
> +	clkout2_clk: clkout2_clk {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&clkoutmux2_clk_mux>;
> +		ti,bit-shift = <8>;
> +		reg = <0x06b0>;
> +	};
> +
>  	l3init_960m_gfclk: l3init_960m_gfclk {
>  		#clock-cells = <0>;
>  		compatible = "ti,gate-clock";
> -- 
> 2.3.0
> 
