From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 23 Jan 2017 19:45:10 +0300
Subject: [PATCH v4 6/9] clocksource/drivers/rockchip_timer: split bc_timer
 into rk_timer and rk_clock_event_device
In-Reply-To: <20170123162624.GG2166@mai>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-7-git-send-email-al.kochet@gmail.com>
 <20170123162624.GG2166@mai>
Message-ID: <EA64873A-7F03-4095-BE38-939183B6457E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel, thanks for reviewing patches!

> 23 ???. 2017 ?., ? 19:26, Daniel Lezcano <daniel.lezcano@linaro.org> ???????(?):
> 
> On Tue, Nov 29, 2016 at 07:14:49PM +0300, Alexander Kochetkov wrote:
>> The patch move ce field out of struct bc_timer into struct
>> rk_clock_event_device and rename struct bc_timer to struct rk_timer.
> 
> Why ?

Single rockchip timer can be either broadcast timer/clockevent (current implementation) or
clocksource (the one I?ve implemented in series). Both implementations based on
low level timer routines (rk_timer_disable, rk_timer_enable, rk_timer_update_counter, 
rk_timer_counter_read and so on). Both implementations use timers in different modes
(interrupts vs free running). In order to distinguish this concepts I tried to split
low level timer routines from bc_timer.

Otherwise I can place all needed clocksource filelds into 'struct bc_timer? and rename 'struct bc_timer?
into 'struct rk_timer?. If this is more clear solution I can rewrite patches.

Alexander.
