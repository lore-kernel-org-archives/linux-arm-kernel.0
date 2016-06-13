From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jun 2016 15:06:25 +0200
Subject: [PATCH v2 0/4] clocksource: rockchip/timer: Support rktimer for
 rk3399
In-Reply-To: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
References: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20160613130625.GC10634@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 12:54:29PM +0800, Caesar Wang wrote:
> This series patches had been tested on rockchip inside kernel.
> In order to support the rk3399 SoC timer and turn off interrupts and IPIs to
> save power in idle.

For my personnal information, are the arch_timer in the same power domain 
than the CPU ? IOW, what is the 'always-on' property in the DT ?

> Okay, it still works bootup on rk3288/other SoCs, even though many socs 
> hasn't used
> the broadcast timer.

Yes, unfortunately the SoC design on rk3288 and the previous ones do not 
allow to use a cpuidle driver with cpu/cluster power down, so obviously the 
broadcast timer is pointless on these boards :)

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

What are you trying to demonstrate here ? There are no interrupts for both 
arch_timer and rk_timer.

> That should work for my board.

What do you mean ?
