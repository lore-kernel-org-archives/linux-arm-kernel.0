From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 17 Nov 2018 15:12:44 -0800
Subject: [PATCH v5 12/18] arm64: dts: qcom: pms405: add gpios
In-Reply-To: <20181109094417.12109-13-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-13-vkoul@kernel.org>
Message-ID: <20181117231244.GC2225@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 09 Nov 01:44 PST 2018, Vinod Koul wrote:

> Add the GPIOs present on PMS405 chip.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 2b275bbdafa3..8e5a8573430e 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -10,6 +10,25 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pms405_gpios: gpio at c000 {
> +			compatible = "qcom,pms405-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				<0 0xc1 0 IRQ_TYPE_NONE>,
> +				<0 0xc2 0 IRQ_TYPE_NONE>,
> +				<0 0xc3 0 IRQ_TYPE_NONE>,
> +				<0 0xc4 0 IRQ_TYPE_NONE>,
> +				<0 0xc5 0 IRQ_TYPE_NONE>,
> +				<0 0xc6 0 IRQ_TYPE_NONE>,
> +				<0 0xc7 0 IRQ_TYPE_NONE>,
> +				<0 0xc8 0 IRQ_TYPE_NONE>,
> +				<0 0xc9 0 IRQ_TYPE_NONE>,
> +				<0 0xca 0 IRQ_TYPE_NONE>,
> +				<0 0xcb 0 IRQ_TYPE_NONE>;
> +		};
> +
>  		rtc at 6000 {
>  			compatible = "qcom,pm8941-rtc";
>  			reg = <0x6000>;
> -- 
> 2.14.4
> 
