From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Dec 2015 12:08:16 +0100
Subject: [PATCH 4/4] ARM: at91/dt: sama5d2 Xplained: pmic needs a specific
 sda hold time
In-Reply-To: <1449052747-20991-4-git-send-email-ludovic.desroches@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-4-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <565ED120.3090603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2015 11:39, Ludovic Desroches a ?crit :
> Data have to been hold longer for the PMIC device.

s/been/be/

It can also be interesting to know where the value comes from...


> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index ad6de73..9bced00 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -129,6 +129,7 @@
>  				dmas = <0>, <0>;
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_i2c0_default>;
> +				i2c-sda-hold-time-ns = <350>;
>  				status = "okay";
>  
>  				pmic: act8865 at 5b {
> 


-- 
Nicolas Ferre
