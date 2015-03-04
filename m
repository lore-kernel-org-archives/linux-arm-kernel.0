From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 11:54:33 +0100
Subject: [PATCH] ARM: at91: dts: sama5d4ek: add leds in DT node
In-Reply-To: <1423474820-19118-1-git-send-email-josh.wu@atmel.com>
References: <1423474820-19118-1-git-send-email-josh.wu@atmel.com>
Message-ID: <54F6E469.8020405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/02/2015 10:40, Josh Wu a ?crit :
> Add the leds DT node in the dts file.
> In the leds, d10 is set as heartbeat led.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

added to at91-4.1-dt branch.

Thanks.

> ---
> 
>  arch/arm/boot/dts/at91-sama5d4ek.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index 9198b71..0c418be 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -257,4 +257,26 @@
>  			gpio-key,wakeup;
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		status = "okay";
> +
> +		d8 {
> +			label = "d8";
> +			/* PE28, conflicts with usart4 rts pin */
> +			gpios = <&pioE 28 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		d9 {
> +			label = "d9";
> +			gpios = <&pioE 9 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		d10 {
> +			label = "d10";
> +			gpios = <&pioE 8 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
> 


-- 
Nicolas Ferre
