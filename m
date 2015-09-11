From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:02:21 +0100
Subject: [PATCH 03/11] ARM: DT: STiH407: Add SPI 3 wire and 4 wire
 pinctrl configs
In-Reply-To: <1441991194-11948-4-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180221.GO18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This patch adds the spi pinctrl configurations for all SPI
> controllers, and also the alternate muxings which
> can be used depending on board design.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 239 ++++++++++++++++++++++++++++++++-
>  1 file changed, 235 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index ce219a1..bb3b0c7 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -262,6 +262,57 @@
>  					};
>  				};
>  			};
> +
> +			spi10 {
> +				pinctrl_spi10_default: spi10-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio4 6 ALT1 OUT>;
> +						mrst = <&pio4 7 ALT1 IN>;
> +						scl = <&pio4 5 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi10_3w_alt1_0: spi10-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio4 6 ALT1 BIDIR_PU>;
> +						scl = <&pio4 5 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
> +			spi11 {
> +				pinctrl_spi11_default: spi11-4w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio3 1 ALT2 OUT>;
> +						mrst = <&pio3 0 ALT2 IN>;
> +						scl = <&pio3 2 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi11_3w_alt2_0: spi11-3w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio3 1 ALT2 BIDIR_PU>;
> +						scl = <&pio3 2 ALT2 OUT>;
> +					};
> +				};
> +			};
> +
> +			spi12 {
> +				pinctrl_spi12_default: spi12-4w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio3 6 ALT2 OUT>;
> +						mrst = <&pio3 4 ALT2 IN>;
> +						scl = <&pio3 7 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi12_3w_alt2_0: spi12-3w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio3 6 ALT2 BIDIR_PU>;
> +						scl = <&pio3 7 ALT2 OUT>;
> +					};
> +				};
> +			};
>  		};
>  
>  		pin-controller-front0 {
> @@ -451,11 +502,159 @@
>  			};
>  
>  			spi0 {
> -				pinctrl_spi0_default: spi0-default {
> +				pinctrl_spi0_default: spi0-4w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio10 6 ALT2 OUT>;
> +						mrst = <&pio10 7 ALT2 IN>;
> +						scl = <&pio10 5 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi0_3w_alt2_0: spi0-3w-alt2-0 {
>  					st,pins {
> -						mtsr = <&pio12 6 ALT2 BIDIR>;
> -						mrst = <&pio12 7 ALT2 BIDIR>;
> -						scl = <&pio12 5 ALT2 BIDIR>;
> +						mtsr = <&pio10 6 ALT2 BIDIR_PU>;
> +						scl = <&pio10 5 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi0_4w_alt1_0: spi0-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio19 7 ALT1 OUT>;
> +						mrst = <&pio19 5 ALT1 IN>;
> +						scl = <&pio19 6 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi0_3w_alt1_0: spi0-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio19 7 ALT1 BIDIR_PU>;
> +						scl = <&pio19 6 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
> +			spi1 {
> +				pinctrl_spi1_default: spi1-4w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio11 1 ALT2 OUT>;
> +						mrst = <&pio11 2 ALT2 IN>;
> +						scl = <&pio11 0 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi1_3w_alt2_0: spi1-3w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio11 1 ALT2 BIDIR_PU>;
> +						scl = <&pio11 0 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi1_4w_alt1_0: spi1-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio14 3 ALT1 OUT>;
> +						mrst = <&pio14 4 ALT1 IN>;
> +						scl = <&pio14 2 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi1_3w_alt1_0: spi1-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio14 3 ALT1 BIDIR_PU>;
> +						scl = <&pio14 2 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
> +			spi2 {
> +				pinctrl_spi2_default: spi2-4w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio12 6 ALT2 OUT>;
> +						mrst = <&pio12 7 ALT2 IN>;
> +						scl = <&pio12 5 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi2_3w_alt2_0: spi2-3w-alt2-0 {
> +					st,pins {
> +						mtsr = <&pio12 6 ALT2 BIDIR_PU>;
> +						scl = <&pio12 5 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi2_4w_alt1_0: spi2-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio14 6 ALT1 OUT>;
> +						mrst = <&pio14 7 ALT1 IN>;
> +						scl = <&pio14 5 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi2_3w_alt1_0: spi2-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio14 6 ALT1 BIDIR_PU>;
> +						scl = <&pio14 5 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi2_4w_alt2_1: spi2-4w-alt2-1 {
> +					st,pins {
> +						mtsr = <&pio15 6 ALT2 OUT>;
> +						mrst = <&pio15 7 ALT2 IN>;
> +						scl = <&pio15 5 ALT2 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi2_3w_alt2_1: spi2-3w-alt2-1 {
> +					st,pins {
> +						mtsr = <&pio15 6 ALT2 BIDIR_PU>;
> +						scl = <&pio15 5 ALT2 OUT>;
> +					};
> +				};
> +			};
> +
> +			spi3 {
> +				pinctrl_spi3_default: spi3-4w-alt3-0 {
> +					st,pins {
> +						mtsr = <&pio13 6 ALT3 OUT>;
> +						mrst = <&pio13 7 ALT3 IN>;
> +						scl = <&pio13 5 ALT3 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi3_3w_alt3_0: spi3-3w-alt3-0 {
> +					st,pins {
> +						mtsr = <&pio13 6 ALT3 BIDIR_PU>;
> +						scl = <&pio13 5 ALT3 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi3_4w_alt1_0: spi3-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio17 7 ALT1 OUT>;
> +						mrst = <&pio17 5 ALT1 IN>;
> +						scl = <&pio17 6 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi3_3w_alt1_0: spi3-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio17 7 ALT1 BIDIR_PU>;
> +						scl = <&pio17 6 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi3_4w_alt1_1: spi3-4w-alt1-1 {
> +					st,pins {
> +						mtsr = <&pio18 6 ALT1 OUT>;
> +						mrst = <&pio18 7 ALT1 IN>;
> +						scl = <&pio18 5 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi3_3w_alt1_1: spi3-3w-alt1-1 {
> +					st,pins {
> +						mtsr = <&pio18 6 ALT1 BIDIR_PU>;
> +						scl = <&pio18 5 ALT1 OUT>;
>  					};
>  				};
>  			};
> @@ -578,6 +777,38 @@
>  					};
>  				};
>  			};
> +
> +			spi4 {
> +				pinctrl_spi4_default: spi4-4w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio30 1 ALT1 OUT>;
> +						mrst = <&pio30 2 ALT1 IN>;
> +						scl = <&pio30 0 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi4_3w_alt1_0: spi4-3w-alt1-0 {
> +					st,pins {
> +						mtsr = <&pio30 1 ALT1 BIDIR_PU>;
> +						scl = <&pio30 0 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi4_4w_alt3_0: spi4-4w-alt3-0 {
> +					st,pins {
> +						mtsr = <&pio34 1 ALT3 OUT>;
> +						mrst = <&pio34 2 ALT3 IN>;
> +						scl = <&pio34 0 ALT3 OUT>;
> +					};
> +				};
> +
> +				pinctrl_spi4_3w_alt3_0: spi4-3w-alt3-0 {
> +					st,pins {
> +						mtsr = <&pio34 1 ALT3 BIDIR_PU>;
> +						scl = <&pio34 0 ALT3 OUT>;
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
