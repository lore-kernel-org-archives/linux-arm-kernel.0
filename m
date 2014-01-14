From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 14 Jan 2014 09:40:10 +0100
Subject: [PATCH] clocksource: arch_timer: Set dynamic irq affinity on
 mmio clockevent
In-Reply-To: <1389048977-13502-1-git-send-email-sboyd@codeaurora.org>
References: <1389048977-13502-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <52D4F7EA.6060200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 11:56 PM, Stephen Boyd wrote:
> Set the CLOCK_EVT_FEAT_DYNIRQ flag on the memory mapped
> clockevent so that we save power by waking up the CPU with the
> next event when this timer is used in broadcast mode.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   drivers/clocksource/arm_arch_timer.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 95fb944e15ee..57e823c44d2a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -277,6 +277,7 @@ static void __arch_timer_setup(unsigned type,
>   			clk->set_next_event = arch_timer_set_next_event_phys;
>   		}
>   	} else {
> +		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
>   		clk->name = "arch_mem_timer";
>   		clk->rating = 400;
>   		clk->cpumask = cpu_all_mask;
>

Applied in my tree for 3.15.

I am curious how much you saved in your current scenario. Did you had 
time to do some rough measurements ?

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
