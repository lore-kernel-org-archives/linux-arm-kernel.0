From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 10 Sep 2015 17:24:15 +0200
Subject: [PATCH 2/2] ARM: at91: at91sam9n12ek/dts: fix the led labels name
In-Reply-To: <fca26d7ecb73e9691da4ee85e7e5bd8462638752.1441897573.git.nicolas.ferre@atmel.com>
References: <27620a5315a0fd314e21eac4afbfe87f1350b099.1441897573.git.nicolas.ferre@atmel.com>
 <fca26d7ecb73e9691da4ee85e7e5bd8462638752.1441897573.git.nicolas.ferre@atmel.com>
Message-ID: <20150910152415.GN3237@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/09/2015 at 17:09:47 +0200, Nicolas Ferre wrote :
> From: Josh Wu <josh.wu@atmel.com>
> 
> Correct the led labels in at91sam9n12ek.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9n12ek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index efa75064d38a..186a1705f8d3 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -204,13 +204,13 @@
>  		};
>  
>  		d9 {
> -			label = "d6";
> +			label = "d9";
>  			gpios = <&pioB 5 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger = "nand-disk";
>  		};
>  
>  		d10 {
> -			label = "d7";
> +			label = "d10";
>  			gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};

The only concern being that this renaming will break userspace software
assuming the LEDs are wrongly named. Is there anything that has been
released by atmel that uses the wrong names (and my guess is yess and
that is why there are named as such) and do you care about it?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
