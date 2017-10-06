From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Oct 2017 15:02:41 +0200
Subject: [PATCH v3] ARM: dts: stm32: Add DMAMUX support for STM32H743 SoC
In-Reply-To: <1506694735-14227-1-git-send-email-pierre-yves.mordret@st.com>
References: <1506694735-14227-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <f3de9f94-1010-0382-f2c7-57d30cb371ec@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/29/2017 04:18 PM, Pierre-Yves MORDRET wrote:
> This patch adds DMAMUX support for STM32H743 SoC.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>      v3:
>         * Rebase on v4.14-rc2
>      v2:
>         * Update DTS to be compliant with up-streamed bindings
>      v1:
>         * Initial
> ---
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 58ec227..e8457f6 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi


Applied on stm32-dt-for-v4.15 branch.

Thanks
Alex


> @@ -121,6 +121,7 @@
>   			clocks = <&timer_clk>;
>   			#dma-cells = <4>;
>   			st,mem2mem;
> +			dma-requests = <8>;
>   			status = "disabled";
>   		};
>   
> @@ -138,6 +139,7 @@
>   			clocks = <&timer_clk>;
>   			#dma-cells = <4>;
>   			st,mem2mem;
> +			dma-requests = <8>;
>   			status = "disabled";
>   		};
>   
> @@ -193,6 +195,16 @@
>   				status = "disabled";
>   			};
>   		};
> +
> +		dmamux1: dma-router at 40020800 {
> +			compatible = "st,stm32h7-dmamux";
> +			reg = <0x40020800 0x1c>;
> +			#dma-cells = <3>;
> +			dma-channels = <16>;
> +			dma-requests = <128>;
> +			dma-masters = <&dma1 &dma2>;
> +			clocks = <&timer_clk>;
> +		};
>   	};
>   };
>   
> 
