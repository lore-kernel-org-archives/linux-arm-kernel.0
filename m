From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 14:17:27 +0100
Subject: [PATCH] ARM: at91/dt: at91sam9rl: add rtc
In-Reply-To: <1412181692-21138-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1412181692-21138-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <546C9867.70005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 18:41, Alexandre Belloni :
> Add rtc support to the at91sam9rl dtsi file.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-3.19-dt2

Thanks, bye.

> ---
>  arch/arm/boot/dts/at91sam9rl.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index ab56c8b81dfa..984468a56fa4 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -1059,6 +1059,13 @@
>  					clocks = <&slow_rc_osc &slow_osc>;
>  				};
>  			};
> +
> +			rtc at fffffeb0 {
> +				compatible = "atmel,at91rm9200-rtc";
> +				reg = <0xfffffeb0 0x40>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  
> 


-- 
Nicolas Ferre
