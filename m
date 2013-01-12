From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 16:42:57 -0500
Subject: [PATCH] ARM: Dove: move CuBox led pinctrl to gpio-leds node
In-Reply-To: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1356646870-2903-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130112214257.GF13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Thu, Dec 27, 2012 at 11:21:10PM +0100, Sebastian Hesselbarth wrote:
> gpio-leds has support for pinctrl allocation, make use of it.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove-cubox.dts |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index cdee96f..bed5b62 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -17,6 +17,9 @@
>  
>  	leds {
>  		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_gpio_18>;
> +		pinctrl-names = "default";
> +
>  		power {
>  			label = "Power";
>  			gpios = <&gpio0 18 1>;
> @@ -47,7 +50,7 @@
>  };
>  
>  &pinctrl {
> -	pinctrl-0 = <&pmx_gpio_12 &pmx_gpio_18>;
> +	pinctrl-0 = <&pmx_gpio_12>;
>  	pinctrl-names = "default";
>  
>  	pmx_gpio_12: pmx-gpio-12 {
> -- 
> 1.7.10.4

I'm getting a merge conflict wit hthe above:

&pinctrl {
<<<<<<< HEAD
        pinctrl-0 = <&pmx_gpio_18>;
======= 
        pinctrl-0 = <&pmx_gpio_12>;
>>>>>>> ARM: Dove: move CuBox led pinctrl to gpio-leds node
        pinctrl-names = "default";

        pmx_gpio_18: pmx-gpio-18 {
                marvell,pins = "mpp18";
                marvell,function = "gpio";
        };
};


Am I missing something?

thx,

Jason.
