From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Jun 2013 10:51:55 +0200
Subject: [PATCH 3/5] ARM: at91: dt: rm9200ek: add spi support
In-Reply-To: <1371472710-18535-3-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
 <1371472710-18535-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51CAABAB.5070408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 14:38, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

stacked on at91-3.11-dt

Thanks

> ---
>   arch/arm/boot/dts/at91rm9200ek.dts |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index 1405812..d2d72c3 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -53,6 +53,16 @@
>   				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
>   				status = "okay";
>   			};
> +
> +			spi0: spi at fffe0000 {
> +				status = "okay";
> +				cs-gpios = <&pioA 3 0>, <0>, <0>, <0>;
> +				mtd_dataflash at 0 {
> +					compatible = "atmel,at45", "atmel,dataflash";
> +					spi-max-frequency = <15000000>;
> +					reg = <0>;
> +				};
> +			};
>   		};
>
>   		usb0: ohci at 00300000 {
>


-- 
Nicolas Ferre
