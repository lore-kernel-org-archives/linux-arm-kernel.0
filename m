From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 16:23:09 +0000
Subject: [PATCH v2 4/4] ARM: sti: Provide DT nodes for SBC SSC[0..2]
In-Reply-To: <1417534844-25080-5-git-send-email-lee.jones@linaro.org>
References: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
 <1417534844-25080-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20150121162309.GH22024@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

Can you ping these up please?

> The Synchronous Serial Controller is used to provide SPI.
> 
> These are the ports which are located on the Stand-By Controller (SBC).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
> index 90bc090..80e2407 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -329,5 +329,36 @@
>  
>  			status = "disabled";
>  		};
> +
> +		/* SBC SSC */
> +		spi at 9540000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9540000 0x110>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_sysin>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9541000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9541000 0x110>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_sysin>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
> +
> +		spi at 9542000 {
> +			compatible = "st,comms-ssc4-spi";
> +			reg = <0x9542000 0x110>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_sysin>;
> +			clock-names = "ssc";
> +
> +			status = "disabled";
> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
