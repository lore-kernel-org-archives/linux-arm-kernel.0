From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 26 Oct 2015 18:50:10 +0100
Subject: [PATCH 0/7] clocksource: add missing notrace attribute
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <562E67D2.3020401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 10:02 AM, Jisheng Zhang wrote:
> Some clocksource drivers sched_clock implementation either miss notrace
> attribute or call wasn't notrace function. This series try to fix them.
>
> Jisheng Zhang (7):
>    clocksource: arm_global_timer: fix ftrace
>    clocksource: samsung_pwm_timer: fix ftrace
>    clocksource: pistachio: fix ftrace
>    clocksource: prima2: fix ftrace
>    clocksource: vf_pit_timer: don't trace pit_read_sched_clock()
>    clocksource: digicolor: don't trace digicolor_timer_sched_read()
>    clocksource: fsl_ftm_timer: don't trace ftm_read_sched_clock
>
>   drivers/clocksource/arm_global_timer.c  | 9 +++++++--
>   drivers/clocksource/fsl_ftm_timer.c     | 2 +-
>   drivers/clocksource/samsung_pwm_timer.c | 2 +-
>   drivers/clocksource/time-pistachio.c    | 3 ++-
>   drivers/clocksource/timer-digicolor.c   | 2 +-
>   drivers/clocksource/timer-prima2.c      | 2 +-
>   drivers/clocksource/vf_pit_timer.c      | 2 +-
>   7 files changed, 14 insertions(+), 8 deletions(-)

Hi Jisheng,

I will apply this series as 4.3 fixes.

In the future, could you fix the subject by:

clocksource/drivers/<driver>: [first letter uppercase]...;

Thanks

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
