From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:01:51 +0100
Subject: [PATCH 04/11] ARM: DT: STiH407: Add serial3 pinctrl configuration
In-Reply-To: <1441991194-11948-5-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180151.GN18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> Add missing serial 3 pinctrl config. This can be used
> on b2206 HVK, where it defaults to PIO31[3] & PIO31[4],
> alternate 1.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Eek!

For the patch: Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index bb3b0c7..6c81f35 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -809,6 +809,15 @@
>  					};
>  				};
>  			};
> +
> +			serial3 {
> +				pinctrl_serial3: serial3-0 {
> +					st,pins {
> +						tx = <&pio31 3 ALT1 OUT>;
> +						rx = <&pio31 4 ALT1 IN>;
> +					};
> +				};
> +			};
>  		};
>  
>  		pin-controller-flash {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
