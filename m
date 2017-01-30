From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Jan 2017 15:20:04 +0100
Subject: [PATCH v5 5/8] clocksource/drivers/rockchip_timer: split
 bc_timer into rk_timer and rk_clock_event_device
In-Reply-To: <0E7077EE-0D5A-4653-99EF-E8F2E8FD2FB0@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
 <1485260203-14216-6-git-send-email-al.kochet@gmail.com>
 <20170130131258.GF2206@mai>
 <0E7077EE-0D5A-4653-99EF-E8F2E8FD2FB0@gmail.com>
Message-ID: <20170130142004.GI2206@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 04:55:33PM +0300, Alexander Kochetkov wrote:
> 
> > 30 ???. 2017 ?., ? 16:12, Daniel Lezcano <daniel.lezcano@linaro.org> ???????(?):
> > 
> > I don't get the point of these changes. The patch does not explain why they are
> > needed.
> 
> I?d like to extract timer API from current implementation.
> And to make code more readable I?d like to introduce 'struct rk_timer? what can be
> reused with current implementation and with my patch (8/8). And in order keep patches
> simple and readable I split that into three patches: 5/8, 6/8, 7/8.
> 
> Current implementation named rockchip timer as ?struct bc_timer? (broadcast timer).
> I renamed it to more suitable to it role (may be bad choice).
> 
> Yes, the patch itself looks strange. You are right.
> 
> What do you think about that solution:
> - in the patch 6/8 i will Introduce 'struct rk_timer? and 'struct rk_time_clkevt? (renamed ?struct bc_timer?).

I prefer rk_clksrc and rk_clkevt.

> - rk_timer_init() changes from 5/8 I will merge with 8/8
> - 8/8 introduce 'struct rk_time_clksrc' 
> - 5/8 drop

Ok, let's see what that gives.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
