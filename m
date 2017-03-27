From: drjones@redhat.com (Andrew Jones)
Date: Mon, 27 Mar 2017 10:44:42 +0200
Subject: [PATCH V8 1/3] irq: Add flags to request_percpu_irq function
In-Reply-To: <1490290924-12958-1-git-send-email-daniel.lezcano@linaro.org>
References: <1490290924-12958-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170327084442.xdosrvdzh2pvn7xa@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 06:42:01PM +0100, Daniel Lezcano wrote:
> diff --git a/drivers/clocksource/timer-nps.c b/drivers/clocksource/timer-nps.c
> index da1f798..dbdb622 100644
> --- a/drivers/clocksource/timer-nps.c
> +++ b/drivers/clocksource/timer-nps.c
> @@ -256,7 +256,7 @@ static int __init nps_setup_clockevent(struct device_node *node)
>  		return ret;
>  
>  	/* Needs apriori irq_set_percpu_devid() done in intc map function */
> -	ret = request_percpu_irq(nps_timer0_irq, timer_irq_handler,
> +	ret = request_percpu_irq(nps_timer0_irq, timer_irq_handler, IRQF_TIMER,
>  				 "Timer0 (per-cpu-tick)",
>  				 &nps_clockevent_device);

Wrong parameter order here.

drew
