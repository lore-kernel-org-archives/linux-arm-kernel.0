From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jun 2016 14:15:10 +0200
Subject: [PATCH 03/22] clocksource: clps711x: Changing the compatibility
 string to match with the smallest supported chip
In-Reply-To: <1465024214-22120-4-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-4-git-send-email-shc_work@mail.ru>
Message-ID: <20160613121510.GA10634@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 04, 2016 at 10:09:55AM +0300, Alexander Shiyan wrote:
> This patch changes the compatibility string to match with the smallest
> supported chip (EP7209). Since the DT-support for this CPU is not yet
> announced, this change is safe.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

but please wait for Rob Herring's ack before taking this patch in your tree.

>  Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt | 6 
+++---
>  drivers/clocksource/clps711x-timer.c                              | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
> index cd55b52..d4c62e7 100644
> --- a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
> @@ -1,7 +1,7 @@
>  * Cirrus Logic CLPS711X Timer Counter
>  
>  Required properties:
> -- compatible: Shall contain "cirrus,clps711x-timer".
> +- compatible: Shall contain "cirrus,ep7209-timer".
>  - reg       : Address and length of the register set.
>  - interrupts: The interrupt number of the timer.
>  - clocks    : phandle of timer reference clock.
> @@ -15,14 +15,14 @@ Example:
>  	};
>  
>  	timer1: timer at 80000300 {
> -		compatible = "cirrus,ep7312-timer", "cirrus,clps711x-timer";
> +		compatible = "cirrus,ep7312-timer", "cirrus,ep7209-timer";
>  		reg = <0x80000300 0x4>;
>  		interrupts = <8>;
>  		clocks = <&clks 5>;
>  	};
>  
>  	timer2: timer at 80000340 {
> -		compatible = "cirrus,ep7312-timer", "cirrus,clps711x-timer";
> +		compatible = "cirrus,ep7312-timer", "cirrus,ep7209-timer";
>  		reg = <0x80000340 0x4>;
>  		interrupts = <9>;
>  		clocks = <&clks 6>;
> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
> index cdd86e3..7c65f9e 100644
> --- a/drivers/clocksource/clps711x-timer.c
> +++ b/drivers/clocksource/clps711x-timer.c
> @@ -121,5 +121,5 @@ static void __init clps711x_timer_init(struct device_node *np)
>  		break;
>  	}
>  }
