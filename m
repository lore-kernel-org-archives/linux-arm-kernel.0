From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Nov 2015 08:57:58 +0530
Subject: [PATCH v4 3/4] ARM: dts: Add STM32 DMA support for STM32F429 MCU
In-Reply-To: <1445003956-9150-4-git-send-email-cedric.madianga@gmail.com>
References: <1445003956-9150-1-git-send-email-cedric.madianga@gmail.com>
 <1445003956-9150-4-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20151116032758.GS25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 03:59:15PM +0200, M'boumba Cedric Madianga wrote:
> This patch adds STM32 DMA bindings for STM32F429.

I need an ACK from ARM folks on this one, and I suspect this might need
rebase on 4.4-rc1

> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index d78a481..037eb29 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -174,6 +174,37 @@
>  			reg = <0x40023800 0x400>;
>  			clocks = <&clk_hse>;
>  		};
> +
> +		dma1: dma-controller at 40026000 {
> +			compatible = "st,stm32-dma";
> +			reg = <0x40026000 0x400>;
> +			interrupts = <11>,
> +				     <12>,
> +				     <13>,
> +				     <14>,
> +				     <15>,
> +				     <16>,
> +				     <17>,
> +				     <47>;
> +			clocks = <&rcc 0 21>;
> +			#dma-cells = <4>;
> +		};
> +
> +		dma2: dma-controller at 40026400 {
> +			compatible = "st,stm32-dma";
> +			reg = <0x40026400 0x400>;
> +			interrupts = <56>,
> +				     <57>,
> +				     <58>,
> +				     <59>,
> +				     <60>,
> +				     <68>,
> +				     <69>,
> +				     <70>;
> +			clocks = <&rcc 0 22>;
> +			#dma-cells = <4>;
> +			st,mem2mem;
> +		};
>  	};
>  };
>  
> -- 
> 1.9.1
> 

-- 
~Vinod
