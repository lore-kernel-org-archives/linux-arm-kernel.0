From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 16:57:03 +0100
Subject: [PATCH 5/8] ARM: STi: DT: Add sdhci pin configuration for stih415
In-Reply-To: <1400771902-26553-6-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <1400771902-26553-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140522155703.GF19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds the required pin config for the sdhci controller
> present in the stih415 SoC.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Switch these round - same with all the other patches.

> ---
>  arch/arm/boot/dts/stih415-pinctrl.dtsi | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
>  2 files changed, 33 insertions(+)

[...]

> diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
> index d6f254f..6579b1d 100644
> --- a/arch/arm/boot/dts/stih415.dtsi
> +++ b/arch/arm/boot/dts/stih415.dtsi
> @@ -218,5 +218,17 @@
>  			resets	= <&powerdown STIH415_KEYSCAN_POWERDOWN>,
>  				  <&softreset STIH415_KEYSCAN_SOFTRESET>;
>  		};
> +
> +		mmc0: sdhci at fe81e000 {
> +			compatible = "st,sdhci";
> +			status = "disabled";
> +			reg = <0xfe81e000 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_NONE>;
> +			interrupt-names = "mmcirq";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_mmc0>;
> +			clock-names = "mmc";
> +			clocks = <&clk_s_a1_ls 1>;

Nit: These would be easier to read if the '='s were lined up (using tabs).

> +		};
>  	};
>  };

Apart from that:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
