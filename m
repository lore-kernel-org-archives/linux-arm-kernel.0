From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 4 Mar 2015 22:13:19 +0100
Subject: [PATCH] ARM: at91/dt: add uart0 to sama5d3 DT
In-Reply-To: <1425486402-17580-1-git-send-email-nicolas.ferre@atmel.com>
References: <1425486402-17580-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150304211319.GC14457@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:26 Wed 04 Mar     , Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

please keep in Cc for at91 related work

Best Regards,
J.
> ---
>  arch/arm/boot/dts/sama5d3.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index e30fee2edd55..def05e20e9d6 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -26,6 +26,7 @@
>  		serial2 = &usart1;
>  		serial3 = &usart2;
>  		serial4 = &usart3;
> +		serial5 = &uart0;
>  		gpio0 = &pioA;
>  		gpio1 = &pioB;
>  		gpio2 = &pioC;
> @@ -206,6 +207,17 @@
>  				status = "disabled";
>  			};
>  
> +			uart0: serial at f0024000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf0024000 0x100>;
> +				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_uart0>;
> +				clocks = <&uart0_clk>;
> +				clock-names = "usart";
> +				status = "disabled";
> +			};
> +
>  			pwm0: pwm at f002c000 {
>  				compatible = "atmel,sama5d3-pwm";
>  				reg = <0xf002c000 0x300>;
> @@ -764,6 +776,14 @@
>  					};
>  				};
>  
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE		/* conflicts with PWMFI2, ISI_D8 */
> +							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* conflicts with ISI_PCK */
> +					};
> +				};
> +
>  				usart0 {
>  					pinctrl_usart0: usart0-0 {
>  						atmel,pins =
> @@ -1098,6 +1118,12 @@
>  						atmel,clk-output-range = <0 66000000>;
>  					};
>  
> +					uart0_clk: uart0_clk {
> +						#clock-cells = <0>;
> +						reg = <16>;
> +						atmel,clk-output-range = <0 66000000>;
> +					};
> +
>  					twi0_clk: twi0_clk {
>  						reg = <18>;
>  						#clock-cells = <0>;
> -- 
> 2.1.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
