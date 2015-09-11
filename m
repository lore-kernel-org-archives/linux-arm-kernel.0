From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:02:38 +0100
Subject: [PATCH 02/11] ARM: STi: DT: STiH407: Add i2c3 alternate pin
 configs
In-Reply-To: <1441991194-11948-3-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180238.GP18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> i2c3 controller can use several sets of pins depending
> on board design. This patch adds the missing alternate
> pinconfigs.
> 
> Signed-off-by: Seraphin Bonnaffe <seraphin.bonnaffe@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index d86ccc8..ce219a1 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -430,12 +430,24 @@
>  			};
>  
>  			i2c3 {
> -				pinctrl_i2c3_default: i2c3-default {
> +				pinctrl_i2c3_default: i2c3-alt1-0 {
>  					st,pins {
>  						sda = <&pio18 6 ALT1 BIDIR>;
>  						scl = <&pio18 5 ALT1 BIDIR>;
>  					};
>  				};
> +				pinctrl_i2c3_alt1_1: i2c3-alt1-1 {
> +					st,pins {
> +						sda = <&pio17 7 ALT1 BIDIR>;
> +						scl = <&pio17 6 ALT1 BIDIR>;
> +					};
> +				};
> +				pinctrl_i2c3_alt3_0: i2c3-alt3-0 {
> +					st,pins {
> +						sda = <&pio13 6 ALT3 BIDIR>;
> +						scl = <&pio13 5 ALT3 BIDIR>;
> +					};
> +				};
>  			};
>  
>  			spi0 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
