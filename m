From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:01:04 +0100
Subject: [PATCH 06/11] ARM: DT: STiH407: Add NAND flash controller pin
 configuration
In-Reply-To: <1441991194-11948-7-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180104.GL18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This patch adds NAND flash support controller pin configuration
> for STiH407 family silicon.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index d0f5fdd..cde776b 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -885,6 +885,29 @@
>  					};
>  				};
>  			};
> +
> +			nand {
> +				pinctrl_nand: nand {
> +					st,pins {
> +						nand_cs1 = <&pio40 6 ALT3 OUT>;
> +						nand_cs0 = <&pio40 7 ALT3 OUT>;
> +						nand_d0 = <&pio41 0 ALT3 BIDIR>;
> +						nand_d1 = <&pio41 1 ALT3 BIDIR>;
> +						nand_d2 = <&pio41 2 ALT3 BIDIR>;
> +						nand_d3 = <&pio41 3 ALT3 BIDIR>;
> +						nand_d4 = <&pio41 4 ALT3 BIDIR>;
> +						nand_d5 = <&pio41 5 ALT3 BIDIR>;
> +						nand_d6 = <&pio41 6 ALT3 BIDIR>;
> +						nand_d7 = <&pio41 7 ALT3 BIDIR>;
> +						nand_we = <&pio42 0 ALT3 OUT>;
> +						nand_dqs = <&pio42 1 ALT3 OUT>;
> +						nand_ale = <&pio42 2 ALT3 OUT>;
> +						nand_cle = <&pio42 3 ALT3 OUT>;
> +						nand_rnb = <&pio42 4 ALT3 IN>;
> +						nand_oe = <&pio42 5 ALT3 OUT>;
> +					};
> +				};
> +			};
>  		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
