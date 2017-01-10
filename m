From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 10 Jan 2017 11:59:10 +0100
Subject: [PATCH v4 8/9] ARM: dts: stm32f4: Add external I2S clock
In-Reply-To: <1481638820-29324-9-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-9-git-send-email-gabriel.fernandez@st.com>
Message-ID: <340234ae-8d01-82e0-8a29-06f401c20d75@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 12/13/2016 03:20 PM, Gabriel FERNANDEZ wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch adds an external I2S clock in the DT.
> The I2S clock could be derived from an external I2S clock or by I2S pll.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index e4dae0e..7c7dfbd 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -68,6 +68,12 @@
>  			compatible = "fixed-clock";
>  			clock-frequency = <32000>;
>  		};
> +
> +		clk_i2s_ckin: i2s-ckin {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <0>;
> +		};
>  	};
>
>  	soc {
> @@ -362,7 +368,7 @@
>  			#clock-cells = <2>;
>  			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
>  			reg = <0x40023800 0x400>;
> -			clocks = <&clk_hse>;
> +			clocks = <&clk_hse>, <&clk_i2s_ckin>;
>  			st,syscfg = <&pwrcfg>;
>  		};
>
>
Applied on stm32-dt-for-v4.11

Thanks
