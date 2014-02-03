From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 03 Feb 2014 17:36:03 +0100
Subject: [PATCH 1/2] clocksource: sunxi: Add new compatibles
In-Reply-To: <1391348280-9484-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348280-9484-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52EFC573.2050302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2014 02:37 PM, Maxime Ripard wrote:
> The Allwinner A10 compatibles were following a slightly different compatible
> patterns than the rest of the SoCs for historical reasons. Add compatibles
> matching the other pattern to the timer driver for consistency, and keep the
> older one for backward compatibility.

Hi Maxime,

is it really needed to keep the old pattern ?



> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 5 +++--
>   drivers/clocksource/sun4i_timer.c                                 | 4 ++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
> index 48aeb78..d9e35ae 100644
> --- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
> @@ -2,7 +2,8 @@ Allwinner A1X SoCs Timer Controller
>
>   Required properties:
>
> -- compatible : should be "allwinner,sun4i-timer"
> +- compatible : should be "allwinner,sun4i-a10-timer"
> +               (Deprecated "allwinner,sun4i-timer")
>   - reg : Specifies base physical address and size of the registers.
>   - interrupts : The interrupt of the first timer
>   - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
> @@ -10,7 +11,7 @@ Required properties:
>   Example:
>
>   timer {
> -	compatible = "allwinner,sun4i-timer";
> +	compatible = "allwinner,sun4i-a10-timer";
>   	reg = <0x01c20c00 0x400>;
>   	interrupts = <22>;
>   	clocks = <&osc>;
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index bf497af..de03895 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -196,5 +196,9 @@ static void __init sun4i_timer_init(struct device_node *node)
>   	clockevents_config_and_register(&sun4i_clockevent, rate,
>   					TIMER_SYNC_TICKS, 0xffffffff);
>   }
> +CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
> +		       sun4i_timer_init);
> +
> +/* Deprecated */
>   CLOCKSOURCE_OF_DECLARE(sun4i, "allwinner,sun4i-timer",
>   		       sun4i_timer_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
