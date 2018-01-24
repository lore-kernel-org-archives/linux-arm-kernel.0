From: peda@axentia.se (Peter Rosin)
Date: Wed, 24 Jan 2018 23:12:17 +0100
Subject: [PATCH] ARM: dts: use a correct at24 fallback for
 at91-nattis-2-natte-2
In-Reply-To: <20180124213412.4612-1-brgl@bgdev.pl>
References: <20180124213412.4612-1-brgl@bgdev.pl>
Message-ID: <bd9bdd00-d7ce-e925-2d63-d0fbb86e07e9@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On 2018-01-24 22:34, Bartosz Golaszewski wrote:
> We now require all at24 users to use the "atmel,<model>" fallback in
> device tree for different manufacturers.

I think my patch [3/4] from about a week ago was just a tiny bit
better.
https://lkml.org/lkml/2018/1/16/609

Can we please pick that one directly instead of doing this partial
step?

Cheers,
Peter

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
> index 3ea1d26e1c68..9ae2a9de6123 100644
> --- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
> +++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
> @@ -146,7 +146,7 @@
>  	};
>  
>  	eeprom at 50 {
> -		compatible = "nxp,24c02";
> +		compatible = "nxp,24c02", "atmel,24c02";
>  		reg = <0x50>;
>  		pagesize = <16>;
>  	};
> 
