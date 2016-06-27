From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jun 2016 19:02:40 +0200
Subject: [PATCH] clocksource: arm_arch_timer: control the evtstrm via the
 cmdline
In-Reply-To: <1467045013-27211-1-git-send-email-will.deacon@arm.com>
References: <1467045013-27211-1-git-send-email-will.deacon@arm.com>
Message-ID: <57715C30.4000202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2016 06:30 PM, Will Deacon wrote:
> Disabling the eventstream can be useful for both remotely debugging a
> deployed production system and development of code using WFE-based
> polling loops. Whilst this can currently be controlled via a Kconfig
> option (CONFIG_ARM_ARCH_TIMER_EVTSTREAM), it's often desirable to toggle
> the feature on the command line, so this patch adds a new command-line
> option ("clocksource.arm_arch_timer.evtstrm") to do just that. The
> default behaviour is determined based on CONFIG_ARM_ARCH_TIMER_EVTSTREAM.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

Sounds good for me. I will take it through my tree.

By the way, I would like to do some cleanups in the Kconfig and 
consistently change the Kconfig options to be silent without the 
COMPILE_TEST option.

I am wondering if we can just remove the ARM_ARCH_TIMER_EVTSTREAM option 
with this patch applied and always enable it by default (like what is 
done today).

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
