From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Oct 2017 15:00:25 +0200
Subject: [PATCH v4 4/5] ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
In-Reply-To: <1505399319-14782-5-git-send-email-pierre-yves.mordret@st.com>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-5-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <4b0f5b6c-2755-a7be-ac57-24844ae41f45@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/14/2017 04:28 PM, Pierre-Yves MORDRET wrote:
> This patch adds I2C1 support for STM32F746 SoC.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>      v4:
>      v3:
>          * None
>      v2:
>          * Update I2C SoC device tree with latest Linux version
> ---
> ---
>   arch/arm/boot/dts/stm32f746.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 4506eb9..ddd8f2c 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi

Applied on stm32-dt-for-v4.15 branch.

Thanks
Alex



> @@ -361,6 +361,16 @@
>   					bias-disable;
>   				};
>   			};
> +
> +			i2c1_pins_b: i2c1 at 0 {
> +				pins {
> +					pinmux = <STM32F746_PB9_FUNC_I2C1_SDA>,
> +						 <STM32F746_PB8_FUNC_I2C1_SCL>;
> +					bias-disable;
> +					drive-open-drain;
> +					slew-rate = <0>;
> +				};
> +			};
>   		};
>   
>   		crc: crc at 40023000 {
> @@ -380,6 +390,18 @@
>   			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
>   			assigned-clock-rates = <1000000>;
>   		};
> +
> +		i2c1: i2c at 40005400 {
> +			compatible = "st,stm32f7-i2c";
> +			reg = <0x40005400 0x400>;
> +			interrupts = <31>,
> +				     <32>;
> +			resets = <&rcc STM32F7_APB1_RESET(I2C1)>;
> +			clocks = <&rcc 1 CLK_I2C1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
>   	};
>   };
>   
> 
