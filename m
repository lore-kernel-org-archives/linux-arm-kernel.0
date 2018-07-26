From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 27 Jul 2018 00:10:48 +0530
Subject: [PATCH 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
In-Reply-To: <20180722163601.28346-6-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
 <20180722163601.28346-6-sravanhome@gmail.com>
Message-ID: <20180726184048.GG5220@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 22, 2018 at 06:36:01PM +0200, Saravanan Sekar wrote:
> Add pinctrl nodes for Actions Semi S700 SoC
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 59d29e4ca404..88edac21e03f 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -179,5 +179,11 @@
>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "timer1";
>  		};
> +
> +		pinctrl: pinctrl at e01b0000 {
> +			compatible = "actions,s700-pinctrl";
> +			reg = <0x0 0xe01b0000 0x0 0x1000>;
> +			clocks = <&cmu CLK_GPIO>;
> +		};

Driver/binding/dts are inconsistent. Driver seems to support pinctrl +
gpio + irq but there is no gpio/irq property in dts patch.

Please correct it.

Thanks,
Mani

>  	};
>  };
> -- 
> 2.18.0
> 
