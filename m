From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Sep 2013 14:58:54 +0200
Subject: [PATCH] at91: serial: sam9g25: add usart3 to dtsi
In-Reply-To: <1379594016-9408-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1379594016-9408-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <523AF50E.7020509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2013 14:33, Jiri Prchal :
> Hope it should be in g25 because not all x5 socs have usart3.

Well there is a pending rework of these optional peripherals for sam9x5 
series. So we may end-up with this usart3 declaration in a separated 
file that will be included in both sam9g25 and sam9x25 product 
descriptions (together with the already existing pinctrl declaration 
that resides in at91sam9x5.dtsi).

So, I keep your code and will try to make sure that it is included 
during the move to that model. If you do not see it appearing, please 
remind us then...

Thanks a lot, bye,

> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>   arch/arm/boot/dts/at91sam9g25.dtsi |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
> index b4ec6fe..ba0966f 100644
> --- a/arch/arm/boot/dts/at91sam9g25.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g25.dtsi
> @@ -12,6 +12,10 @@
>   	model = "Atmel AT91SAM9G25 SoC";
>   	compatible = "atmel,at91sam9g25", "atmel,at91sam9x5";
>
> +	aliases {
> +		serial4 = &usart3;
> +	};
> +
>   	ahb {
>   		apb {
>   			pinctrl at fffff400 {
> @@ -23,6 +27,16 @@
>   				       0x003fffff 0x003f8000 0x00000000  /* pioD */
>   				      >;
>   			};
> +
> +			usart3: serial at f8028000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8028000 0x200>;
> +				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usart3>;
> +				status = "disabled";
> +			};
> +
>   		};
>   	};
>   };
>


-- 
Nicolas Ferre
