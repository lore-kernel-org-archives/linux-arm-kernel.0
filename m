From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:01:19 +0100
Subject: [PATCH 05/11] ARM: DT: STiH407: Add SPI FSM (NOR Flash)
 Controller pin config
In-Reply-To: <1441991194-11948-6-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180119.GM18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This patch adds the pin configuration for the NOR flash controller.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index 6c81f35..d0f5fdd 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -872,6 +872,19 @@
>  					};
>  				};
>  			};
> +
> +			fsm {
> +				pinctrl_fsm: fsm {
> +					st,pins {
> +						spi-fsm-clk = <&pio40 1 ALT1 OUT>;
> +						spi-fsm-cs = <&pio40 0 ALT1 OUT>;
> +						spi-fsm-mosi = <&pio40 2 ALT1 OUT>;
> +						spi-fsm-miso = <&pio40 3 ALT1 IN>;
> +						spi-fsm-hol = <&pio40 5 ALT1 OUT>;
> +						spi-fsm-wp = <&pio40 4 ALT1 OUT>;
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
