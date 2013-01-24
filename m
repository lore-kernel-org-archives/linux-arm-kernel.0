From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Jan 2013 16:19:40 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <5101510C.9050407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/23/2013 06:56 PM, Florian Vaussard wrote:
> Convert the on-board LED connected to the TWL4030 (LEDB) to use
> pwm-leds.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index 89808ce..800be29 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -14,12 +14,13 @@
>  /include/ "omap3.dtsi"
>  
>  / {
> -	leds {
> -		compatible = "gpio-leds";
> +	pwmleds {
> +		compatible = "pwm-leds";
> +
>  		overo {
>  			label = "overo:blue:COM";
> -			gpios = <&twl_gpio 19 0>;
> -			linux,default-trigger = "mmc0";

You can keep the default trigger for the pwm-leds as well.
The best way to test this is on top of linux-next which already have the
leds-pwm DT bindings.

> +			pwms = <&twl_pwmled 1 7812500>;
> +			max-brightness = <127>;
>  		};
>  	};
>  };
> 


-- 
P?ter
