From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 18:57:00 +0100
Subject: [PATCH 10/11] ARM: DT: STiH407: Add RMII pinctrl support
In-Reply-To: <1441991194-11948-11-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-11-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911175700.GH18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This patch adds the RMII pinctrl support for the Synopsys
> MAC on STiH407 SoCs.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index 473f2ea..e80cac5 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -256,6 +256,33 @@
>  						phyclk = <&pio2 3 ALT1 OUT NICLK 0 CLK_A>;
>  					};
>  				};
> +
> +				pinctrl_rmii1: rmii1-0 {
> +					st,pins {
> +						txd0 = <&pio0 0 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
> +						txd1 = <&pio0 1 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
> +						txen = <&pio0 5 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
> +						mdio = <&pio1 0 ALT1 OUT BYPASS 0>;
> +						mdc = <&pio1 1 ALT1 OUT NICLK 0 CLK_A>;
> +						mdint = <&pio1 3 ALT1 IN BYPASS 0>;
> +						rxd0 = <&pio1 4 ALT1 IN SE_NICLK_IO 0 CLK_B>;
> +						rxd1 = <&pio1 5 ALT1 IN SE_NICLK_IO 0 CLK_B>;
> +						rxdv = <&pio2 0 ALT1 IN SE_NICLK_IO 0 CLK_B>;
> +						rx_er = <&pio2 1 ALT1 IN SE_NICLK_IO 0 CLK_A>;
> +					};
> +				};
> +
> +				pinctrl_rmii1_phyclk: rmii1_phyclk {
> +					st,pins {
> +						phyclk = <&pio2 3 ALT1 OUT NICLK 0 CLK_A>;
> +					};
> +				};
> +
> +				pinctrl_rmii1_phyclk_ext: rmii1_phyclk_ext {
> +					st,pins {
> +						phyclk = <&pio2 3 ALT2 IN NICLK 0 CLK_A>;
> +					};
> +				};
>  			};
>  
>  			pwm1 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
