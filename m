From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 Nov 2016 11:15:24 +0100
Subject: [PATCH 1/2] ARM: dts: stm32f429: add LSI and LSE clocks
In-Reply-To: <1478249577-25999-2-git-send-email-gabriel.fernandez@st.com>
References: <1478249577-25999-1-git-send-email-gabriel.fernandez@st.com>
 <1478249577-25999-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <3974b516-d698-ab7f-efba-d768eccbd56f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gabriel,

On 11/04/2016 09:52 AM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch adds lsi / lse oscillators. These clocks can be use by
> RTC clocks.
> The clock drivers needs to disable the power domain write protection using
> syscon / regmap to enable these clocks.
>

Is it the same than you sent in last series ? If yes I will take it 
directly as review has already been done.

regards
Alex

> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 336ee4f..2700449 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -56,6 +56,18 @@
>  			compatible = "fixed-clock";
>  			clock-frequency = <0>;
>  		};
> +
> +		clk-lse {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		clk-lsi {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +		};
>  	};
>
>  	soc {
> @@ -185,6 +197,11 @@
>  			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>  		};
>
> +		pwrcfg: power-config at 40007000 {
> +			compatible = "syscon";
> +			reg = <0x40007000 0x400>;
> +		};
> +
>  		pin-controller {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -340,6 +357,7 @@
>  			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
>  			reg = <0x40023800 0x400>;
>  			clocks = <&clk_hse>;
> +			st,syscfg = <&pwrcfg>;
>  		};
>
>  		dma1: dma-controller at 40026000 {
>
