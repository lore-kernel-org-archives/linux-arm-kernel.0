From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 21 Sep 2015 09:31:03 +0300
Subject: [PATCH 14/14] ARM: dts: qs600: Add SD card detect support.
In-Reply-To: <1442579538-20525-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1442579538-20525-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55FFA427.1020001@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/15 15:32, Srinivas Kandagatla wrote:
> This patch adds SD card detect support.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> index cc9d942..03784f1 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> @@ -29,6 +29,16 @@
>  	};
>  
>  	soc {
> +		pinctrl at 800000 {
> +			card_detect: card_detect {
> +				mux {
> +					pins = "gpio26";
> +					function = "gpio";
> +					bias-disable;
> +				};
> +			};
> +		};
> +
>  		rpm at 108000 {
>  			regulators {
>  				vin_lvs1_3_6-supply = <&pm8921_s4>;
> @@ -197,6 +207,9 @@
>  			sdcc3: sdcc at 12180000 {
>  				status = "okay";
>  				vmmc-supply = <&v3p3_fixed>;
> +				pinctrl-names	= "default";
> +				pinctrl-0	= <&card_detect>;
> +				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
>  			};
>  			/* WLAN */
>  			sdcc4: sdcc at 121c0000 {
> 

-- 
Regards,
Igor.
