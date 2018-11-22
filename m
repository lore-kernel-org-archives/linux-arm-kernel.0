From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 22 Nov 2018 14:23:41 +0100
Subject: [RFC PATCH v3 07/17] clocksource: sun4i: add a compatible for
 suniv
In-Reply-To: <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <a732f908-c70e-ce30-ad18-ddbb6879995f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/2018 19:30, Mesih Kilinc wrote:
> The suniv (new F-series) chip has a timer with less functionality than
> the A10 timer, e.g. it has only 3 channels.
> 
> Add a new compatible for it. As we didn't use the extra channels on A10
> either now, the code needn't to be changed.
> 
> The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.
> 
> Register sun4i_timer as sched_clock on it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/clocksource/sun4i_timer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index 6e0180a..65f38f6 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
>  	 */
>  	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
>  	    of_machine_is_compatible("allwinner,sun5i-a13") ||
> -	    of_machine_is_compatible("allwinner,sun5i-a10s"))
> +	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
> +	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
>  		sched_clock_register(sun4i_timer_sched_read, 32,
>  				     timer_of_rate(&to));
>  
> @@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
>  }
>  TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>  		       sun4i_timer_init);
> +TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
> +		       sun4i_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
