From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 6 Jul 2018 21:39:23 +0200
Subject: [PATCH v5 4/5] ARM: dts: at91: sama5d2: add nodes for I2S
 controllers
In-Reply-To: <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-5-codrin.ciubotariu@microchip.com>
Message-ID: <20180706193923.GC16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Codrin,

On 18/06/2018 17:12:38+0300, Codrin Ciubotariu wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
> each I2S node.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> [codrin.ciubotariu at microchip.com: added phandle to new mux clock]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> The bindings for the I2S node are applied to broonie/sound.git .
> 
> Changes in v5:
> 	- the previous name was:
> 	  [PATCH v4 6/7] ARM: dts: at91: sama5d2: add nodes for I2S controllers
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index eeb6afa1cda7..eca73ce40bc5 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -58,6 +58,8 @@
>  		serial1 = &uart3;
>  		tcb0 = &tcb0;
>  		tcb1 = &tcb1;
> +		i2s0 = &i2s0;
> +		i2s1 = &i2s1;
>  	};
>  
>  	cpus {
> @@ -1313,6 +1315,22 @@
>  				clocks = <&clk32k>;
>  			};
>  
> +			i2s0: i2s at f8050000 {
> +				compatible = "atmel,sama5d2-i2s";
> +				reg = <0xf8050000 0x100>;
> +				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
> +				dmas = <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(31))>,
> +				       <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(32))>;
> +				dma-names = "tx", "rx";
> +				clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
> +				clock-names = "pclk", "gclk", "aclk", "muxclk";
> +				status = "disabled";
> +			};
> +

Can you resend the DTS patches after removing the unnecessary clocks?

Thanks,

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
