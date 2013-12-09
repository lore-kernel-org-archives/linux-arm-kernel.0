From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 09 Dec 2013 15:05:46 +0100
Subject: [PATCH] ARM: at91/at91rm9200ek.dts: rearrange nodes in address
 ascending order
In-Reply-To: <1386596612-26818-1-git-send-email-nicolas.ferre@atmel.com>
References: <1386596612-26818-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <52A5CE3A.7070900@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2013 14:43, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Boris BREZILLON<b.brezillon@overkiz.com>
> ---
>   arch/arm/boot/dts/at91rm9200ek.dts | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index 31f5c3293d07..df6b0aa0e4dd 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -29,18 +29,9 @@
>   
>   	ahb {
>   		apb {
> -			dbgu: serial at fffff200 {
> -				status = "okay";
> -			};
> -
> -			usart1: serial at fffc4000 {
> -				pinctrl-0 =
> -						<&pinctrl_uart1
> -						 &pinctrl_uart1_rts
> -						 &pinctrl_uart1_cts
> -						 &pinctrl_uart1_dtr_dsr
> -						 &pinctrl_uart1_dcd
> -						 &pinctrl_uart1_ri>;
> +			usb1: gadget at fffb0000 {
> +				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
> +				atmel,pullup-gpio = <&pioD 5 GPIO_ACTIVE_HIGH>;
>   				status = "okay";
>   			};
>   
> @@ -54,9 +45,14 @@
>   				};
>   			};
>   
> -			usb1: gadget at fffb0000 {
> -				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
> -				atmel,pullup-gpio = <&pioD 5 GPIO_ACTIVE_HIGH>;
> +			usart1: serial at fffc4000 {
> +				pinctrl-0 =
> +						<&pinctrl_uart1
> +						 &pinctrl_uart1_rts
> +						 &pinctrl_uart1_cts
> +						 &pinctrl_uart1_dtr_dsr
> +						 &pinctrl_uart1_dcd
> +						 &pinctrl_uart1_ri>;
>   				status = "okay";
>   			};
>   
> @@ -69,6 +65,10 @@
>   					reg = <0>;
>   				};
>   			};
> +
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
>   		};
>   
>   		usb0: ohci at 00300000 {
