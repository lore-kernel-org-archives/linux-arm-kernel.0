From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 12 Jul 2012 18:05:46 +0200
Subject: IRQ and FIQ disabling during sleep states.
In-Reply-To: <20120711123020.GW2416@tbergstrom-lnx.Nvidia.com>
References: <20120711123020.GW2416@tbergstrom-lnx.Nvidia.com>
Message-ID: <4FFEF5DA.8000505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2012 02:30 PM, Peter De Schrijver wrote:
> Hi,
> 
> I noticed several platforms exhibit different behaviour wrt disabling IRQ or
> FIQ when entering a CPU idle state. Tegra for example disables both FIQ and
> IRQ when entering CPU clockstop, but OMAP seems to only disable FIQs? Also
> the generic cpuidle_wrap_enter() function, enables IRQs after return from
> the idle state, but doesn't disable them.
> 
> Some questions:
> 
> 1) I assume we need to disable IRQ/FIQ to not confuse the cpuidle code due to
>    late interrupts?
> 2) What prevents us from unifying this?


AFAIR, Rob Lee discussed about this point already. Maybe he has a
pointer to the discussion.



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
