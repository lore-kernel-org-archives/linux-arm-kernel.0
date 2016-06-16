From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 16:26:22 +0200
Subject: [PATCH v2 0/4] clocksource: rockchip/timer: Support rktimer for
 rk3399
In-Reply-To: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
References: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
Message-ID: <5762B70E.7090909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 06:54 AM, Caesar Wang wrote:
> This series patches had been tested on rockchip inside kernel.
> In order to support the rk3399 SoC timer and turn off interrupts and IPIs to
> save power in idle.
> Okay, it still works bootup on rk3288/other SoCs, even though many socs hasn't used
> the broadcast timer.
>
> History version:
> v1:
> https://lkml.org/lkml/2016/5/25/186
>
> Easy to test for my borad.
> localhost / # cat /proc/interrupts
> CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> 1:          0          0          0          0          0          0     GICv3  29 Edge      arch_timer
> ...
> 5:          0          0          0          0          0          0     GICv3 113 Level     rk_timer
> ..
>
> localhost / # cat /proc/timer_list | grep event_handler
> get "event_handler:  hrtimer_interrupt"
> event_handler:  tick_handle_oneshot_broadcast
> event_handler:  hrtimer_interrupt
>
> That should work for my board.

Hi Caesar,

I applied the patches on my tree. I humbly reworded the changelog, if 
you disagree with the content, let me know.

Please, in the future, take care of the following:

  - patch prefix is 'clocksource/driver/<driver_name>: [A-Z].*'

  - the change log is important, it deserves some love.

Thanks.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
