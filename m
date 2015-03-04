From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 4 Mar 2015 11:04:37 +0100
Subject: [PATCH] ARM: at91/dt: keep watchdog running in idle mode
In-Reply-To: <549954F7.9070009@objectxp.com>
References: <549954F7.9070009@objectxp.com>
Message-ID: <20150304110437.71c46526@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Dec 2014 12:41:43 +0100
Michel Marti <mma@objectxp.com> wrote:

> Since turning on idle-halt in commit fe46aa679, SoCs compatible with
> the sam9 watchdog no longer reboot if the wdt times out. Removing the
> 'idle-halt' flag fixes this.
> 
> Signed-off-by: Michel Marti <mma@objectxp.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 1 -
>  arch/arm/boot/dts/at91sam9263.dtsi | 1 -
>  arch/arm/boot/dts/at91sam9g45.dtsi | 1 -
>  arch/arm/boot/dts/at91sam9n12.dtsi | 1 -
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 1 -
>  arch/arm/boot/dts/sama5d3.dtsi     | 1 -
>  6 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index dd1313c..184e1d1 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -971,7 +971,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 1467750..c39556b 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -874,7 +874,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 2a8da8a..b8d741d 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -1111,7 +1111,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 68eb9ad..e0b5c24 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -889,7 +889,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index bbb3ba6..ce61f91 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -1125,7 +1125,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 5f4144d..63d12ed 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -1224,7 +1224,6 @@
>                  atmel,watchdog-type = "hardware";
>                  atmel,reset-type = "all";
>                  atmel,dbg-halt;
> -                atmel,idle-halt;
>                  status = "disabled";
>              };
>  



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
