From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 9 Jan 2017 15:48:42 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: enable ADC on stm32f429i-eval board
In-Reply-To: <1480687022-12851-4-git-send-email-fabrice.gasnier@st.com>
References: <1480687022-12851-1-git-send-email-fabrice.gasnier@st.com>
 <1480687022-12851-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <56abb501-7920-9b8a-2a82-35d43f40dc12@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice

On 12/02/2016 02:57 PM, Fabrice GASNIER wrote:
> Enable analog to digital converter on stm32f429i-eval board.
> It has on-board potentimeter wired to ADC3 in8 analog pin and
> uses fixed regulator to provide reference voltage.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  arch/arm/boot/dts/stm32429i-eval.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 13c7cd2..6be0a24 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -65,6 +65,20 @@
>  		serial0 = &usart1;
>  	};
>
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_vref: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "vref";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		green {
> @@ -123,3 +137,14 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&adc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&adc3_in8_pin>;
> +	vref-supply = <&reg_vref>;
> +	status = "okay";
> +	adc3: adc at 200 {
> +		st,adc-channels = <8>;
> +		status = "okay";
> +	};
> +};
>
After node reordering:

Applied on stm32-dt-for-v4.11

Thanks
Alex
