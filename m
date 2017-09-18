From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 18 Sep 2017 23:52:07 +0200
Subject: [PATCH 3/4] clocksource: owl: Prepare S700
In-Reply-To: <20170911022241.11603-4-afaerber@suse.de>
References: <20170911022241.11603-1-afaerber@suse.de>
 <20170911022241.11603-4-afaerber@suse.de>
Message-ID: <b62d9ae5-8aac-14a5-d887-9a54759a3bbe@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2017 04:22, Andreas F?rber wrote:
> S700 has two 2Hz timers like S500, and four TIMx timers like S900.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/clocksource/owl-timer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
> index d19c53c11094..d5f3f72c10ee 100644
> --- a/drivers/clocksource/owl-timer.c
> +++ b/drivers/clocksource/owl-timer.c
> @@ -169,4 +169,5 @@ static int __init owl_timer_init(struct device_node *node)
>  	return 0;
>  }
>  CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
> +CLOCKSOURCE_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
>  CLOCKSOURCE_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);

Can you take the opportunity to fix the deprecated
CLOCKSOURCE_OF_DECLARE by replacing it by TIMER_OF_DECLARE ?

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
