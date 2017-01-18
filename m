From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jan 2017 09:23:38 +0000
Subject: [PATCH] ARM: DT: STiH407: Add RTS / CTS pinctrl definition for
 UARTs.
In-Reply-To: <1484671615-16343-1-git-send-email-peter.griffin@linaro.org>
References: <1484671615-16343-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20170118092338.GE3718@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of nits and a question.

On Tue, 17 Jan 2017, Peter Griffin wrote:

> The uart IP is capable of doing hardware flow control. Define

UART

> the RTS and CTS pins for STiH407 family Socs so we can use this

SoCs

> feature in the future if we wish to.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 50 ++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index daab16b..3bbb0c0 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -149,6 +149,16 @@
>  						rx = <&pio3 5 ALT1 IN>;
>  					};
>  				};
> +				pinctrl_sbc_serial0_rts: sbc_serial0-0_rts {
> +					st,pins {
> +						rts = <&pio3 7 ALT1 OUT>;
> +					};
> +				};
> +				pinctrl_sbc_serial0_cts: sbc_serial0-0_cts {
> +					st,pins {
> +						cts = <&pio3 6 ALT1 IN>;
> +					};
> +				};

Basic premise looks good, but why have you separated the lines?

I believe they are used together when HW flow-control is enabled.

>  			};
>  			/* SBC_ASC1 - UART11 */
>  			sbc_serial1 {
> @@ -158,6 +168,16 @@
>  						rx = <&pio2 7 ALT3 IN>;
>  					};
>  				};
> +				pinctrl_sbc_serial1_rts: sbc_serial1-0_rts {
> +					st,pins {
> +						rts = <&pio3 1 ALT3 OUT>;
> +					};
> +				};
> +				pinctrl_sbc_serial1_cts: sbc_serial1-0_cts {
> +					st,pins {
> +						cts = <&pio3 0 ALT3 IN>;
> +					};
> +				};
>  			};
>  
>  			i2c10 {
> @@ -469,6 +489,16 @@
>  						rx = <&pio17 1 ALT1 IN>;
>  					};
>  				};
> +				pinctrl_serial0_rts: serial0-0_rts {
> +					st,pins {
> +						rts = <&pio17 3	ALT1 OUT>;
> +					};
> +				};
> +				pinctrl_serial0_cts: serial0-0_cts {
> +					st,pins {
> +						cts = <&pio17 2	ALT1 IN>;
> +					};
> +				};
>  			};
>  
>  			serial1 {
> @@ -478,6 +508,16 @@
>  						rx = <&pio16 1 ALT1 IN>;
>  					};
>  				};
> +				pinctrl_serial1_rts: serial1-0_rts {
> +					st,pins {
> +						rts = <&pio16 3	ALT1 OUT>;
> +					};
> +				};
> +				pinctrl_serial1_cts: serial1-0_cts {
> +					st,pins {
> +						cts = <&pio16 2 ALT1 IN>;
> +					};
> +				};
>  			};
>  
>  			serial2 {
> @@ -487,6 +527,16 @@
>  						rx = <&pio15 1 ALT1 IN>;
>  					};
>  				};
> +				pinctrl_serial2_rts: serial2-0_rts {
> +					st,pins {
> +						rts = <&pio15 3	ALT1 OUT>;
> +					};
> +				};
> +				pinctrl_serial2_cts: serial2-0_cts {
> +					st,pins {
> +						cts = <&pio15 2	ALT1 IN>;
> +					};
> +				};
>  			};
>  
>  			mmc1 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
