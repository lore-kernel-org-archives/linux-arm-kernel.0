From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:29:46 -0700
Subject: [PATCH 02/12] ARM: dts: apq8064: add support to gsbi1 uart
In-Reply-To: <1458762429-9397-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762429-9397-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160329142946.GG8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:

> This patch adds support to gsbi1 uart and its pinctrls nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/qcom-apq8064.dtsi      | 10 ++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> index b57c59d..8bb5e5f 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> @@ -39,6 +39,20 @@
>  		};
>  	};
>  
> +	gsbi1_uart_2pins: gsbi1_uart_2pins {
> +		mux {
> +			pins = "gpio18", "gpio19";
> +			function = "gsbi1";
> +		};
> +	};
> +
> +	gsbi1_uart_4pins: gsbi1_uart_4pins {
> +		mux {
> +			pins = "gpio18", "gpio19", "gpio20", "gpio21";
> +			function = "gsbi1";
> +		};
> +	};
> +

No-one consumes this nodes.

>  	i2c2_pins: i2c2 {
>  		mux {
>  			pins = "gpio24", "gpio25";
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index c6ff8fc..81b4290 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -225,6 +225,16 @@
>  
>  			syscon-tcsr = <&tcsr>;
>  
> +			gsbi1_serial: serial at 12450000 {

Are you going to reference this node? Otherwise it should not have a
label.

> +				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> +				reg = <0x12450000 0x100>,
> +				      <0x12400000 0x03>;
> +				interrupts = <0 193 0x0>;
> +				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};
> +

Regards,
Bjorn
