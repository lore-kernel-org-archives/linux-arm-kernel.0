From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 18 May 2015 17:52:43 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: update pinctrl ranges
In-Reply-To: <1430126106-15300-1-git-send-email-ludovic.desroches@atmel.com>
References: <1430126106-15300-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <555A0ACB.1060603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/04/2015 11:15, Ludovic Desroches a ?crit :
> Update the pinctrl ranges property to support pioD controller whose
> mapping is not contiguous with other pio controllers. Without this
> update, getting resource will fail, then pinctrl probe will fail too
> because there is a missing pio controller.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 8679fa9..2cfc65f 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1214,7 +1214,8 @@
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
> -				ranges = <0xfc06a000 0xfc06a000 0x4000>;
> +				ranges = <0xfc068000 0xfc068000 0x100
> +					  0xfc06a000 0xfc06a000 0x4000>;
>  				/* WARNING: revisit as pin spec has changed */
>  				atmel,mux-mask = <
>  					/*   A          B          C  */
> 


-- 
Nicolas Ferre
