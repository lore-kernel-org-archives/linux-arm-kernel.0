From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 18:45:11 +0100
Subject: [PATCH 05/17] clocksource: time-armada-370-xp: add suspend/resume
 support
In-Reply-To: <1414151970-6626-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457BF27.8000108@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> This commit adds a set of suspend/resume syscore_ops to respectively
> save and restore a number of timer registers, in order to make sure
> the clockevent and clocksource devices continue to work properly
> accross a suspend/resume cycle.
  across

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clocksource/time-armada-370-xp.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 0451e62..1a32dcb 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -43,6 +43,7 @@
>  #include <linux/module.h>
>  #include <linux/sched_clock.h>
>  #include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
>  
>  /*
>   * Timer block registers.
> @@ -223,6 +224,28 @@ static struct notifier_block armada_370_xp_timer_cpu_nb = {
>  	.notifier_call = armada_370_xp_timer_cpu_notify,
>  };
>  
> +static u32 timer_ctrl_reg, timer_local_ctrl_reg;

We don't need to restore any other timer than the timer 0, but it
would worth mentioning that we save and restore only this one
by naming the variable timer0_ctrl_reg and timer0_local_ctrl_reg

Besides this and the typo:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
