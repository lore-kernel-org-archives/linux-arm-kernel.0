From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 27 Jul 2017 09:28:04 +0200
Subject: [PATCH] ARM: dts: stm32: Add DAC support on stm32h7
In-Reply-To: <1499687946-29853-1-git-send-email-fabrice.gasnier@st.com>
References: <1499687946-29853-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <d68d3fcc-7ab3-fb25-9681-1fe2a610a82b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice

On 07/10/2017 01:59 PM, Fabrice Gasnier wrote:
> Add support for DAC (Digital to Analog Converter) to STM32H7.
> STM32H7 DAC has two output channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 4685629..d0b28c5 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -74,6 +74,30 @@
>   			interrupts = <50>;
>   			clocks = <&timer_clk>;
>   		};
> +
> +		dac: dac at 40007400 {
> +			compatible = "st,stm32h7-dac-core";
> +			reg = <0x40007400 0x400>;
> +			clocks = <&timer_clk>;
> +			clock-names = "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			dac1: dac at 1 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <1>;
> +				status = "disabled";
> +			};
> +
> +			dac2: dac at 2 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <2>;
> +				status = "disabled";
> +			};
> +		};
>   	};
>   };
>   
> 
Applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
