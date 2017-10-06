From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Oct 2017 15:01:10 +0200
Subject: [PATCH v2 3/3] ARM: dts: stm32: add vrefbuf to stm32h743
In-Reply-To: <1504108529-31727-4-git-send-email-fabrice.gasnier@st.com>
References: <1504108529-31727-1-git-send-email-fabrice.gasnier@st.com>
 <1504108529-31727-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <46c381ed-f096-5da5-c352-89a044aea10d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

On 08/30/2017 05:55 PM, Fabrice Gasnier wrote:
> Add STM32H743 VREFBUF (Voltage Reference Buffer) definition.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 36a99db..83ee8fe 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -82,6 +82,15 @@
>   			interrupts = <50>;
>   			clocks = <&timer_clk>;
>   		};
> +
> +		vrefbuf: regulator at 58003C00 {
> +			compatible = "st,stm32-vrefbuf";
> +			reg = <0x58003C00 0x8>;
> +			clocks = <&timer_clk>;
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <2500000>;
> +			status = "disabled";
> +		};
>   	};
>   };
>   
> 
Applied on stm32-dt-for-v4.15 branch.

Thanks
Alex
