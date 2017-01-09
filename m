From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 9 Jan 2017 15:46:55 +0100
Subject: [PATCH 2/3] ARM: dts: stm32: Add ADC support to stm32f429
In-Reply-To: <1480687022-12851-3-git-send-email-fabrice.gasnier@st.com>
References: <1480687022-12851-1-git-send-email-fabrice.gasnier@st.com>
 <1480687022-12851-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <cdfb7781-196a-ad78-45e0-53c47fe7b532@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice

On 12/02/2016 02:57 PM, Fabrice GASNIER wrote:
> Add ADC support & pinctrl analog phandle (adc3_in8) to stm32f429.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 3dd47eb..be1d970 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -172,6 +172,49 @@
>  			status = "disabled";
>  		};
>
> +		adc: adc at 40012000 {
> +			compatible = "st,stm32f4-adc-core";
> +			reg = <0x40012000 0x400>;
> +			interrupts = <18>;
> +			clocks = <&rcc 0 168>;
> +			clock-names = "adc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			adc1: adc at 0 {
> +				compatible = "st,stm32f4-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x0>;
> +				clocks = <&rcc 0 168>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <0>;
> +				status = "disabled";
> +			};
> +
> +			adc2: adc at 100 {
> +				compatible = "st,stm32f4-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x100>;
> +				clocks = <&rcc 0 169>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <1>;
> +				status = "disabled";
> +			};
> +
> +			adc3: adc at 200 {
> +				compatible = "st,stm32f4-adc";
> +				#io-channel-cells = <1>;
> +				reg = <0x200>;
> +				clocks = <&rcc 0 170>;
> +				interrupt-parent = <&adc>;
> +				interrupts = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		syscfg: system-config at 40013800 {
>  			compatible = "syscon";
>  			reg = <0x40013800 0x400>;
> @@ -334,6 +377,12 @@
>  					slew-rate = <2>;
>  				};
>  			};
> +
> +			adc3_in8_pin: adc at 200 {
> +				pins {
> +					pinmux = <STM32F429_PF10_FUNC_ANALOG>;
> +				};
> +			};
>  		};
>
>  		rcc: rcc at 40023810 {
>

Applied on stm32-dt-for-v4.11

Thanks
Alex
