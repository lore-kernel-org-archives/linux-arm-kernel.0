From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 16:26:44 +0200
Subject: [PATCH 17/17] ARM: use new LEDS CPU trigger stub to replace old
	one
In-Reply-To: <1309955687-19365-18-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-18-git-send-email-bryan.wu@canonical.com>
Message-ID: <201107061626.44256.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Bryan Wu wrote:
> 
>  #include <asm/cacheflush.h>
> -#include <asm/leds.h>
>  #include <asm/processor.h>
>  #include <asm/system.h>
>  #include <asm/thread_notify.h>
> @@ -183,7 +183,7 @@ void cpu_idle(void)
>         /* endless idle loop with no priority at all */
>         while (1) {
>                 tick_nohz_stop_sched_tick(1);
> -               leds_event(led_idle_start);
> +               ledtrig_cpu(CPU_LED_IDLE_START);
>                 while (!need_resched()) {
>  #ifdef CONFIG_HOTPLUG_CPU
>                         if (cpu_is_offline(smp_processor_id()))
> @@ -207,7 +207,7 @@ void cpu_idle(void)
>                                 local_irq_enable();
>                         }
>                 }
> -               leds_event(led_idle_end);
> +               ledtrig_cpu(CPU_LED_IDLE_END);
>                 tick_nohz_restart_sched_tick();
>                 preempt_enable_no_resched();
>                 schedule();

Nevermind my previous comment about the place where this is used. I've found it now ;-)

	Arnd
