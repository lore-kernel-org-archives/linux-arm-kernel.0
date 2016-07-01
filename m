From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 1 Jul 2016 16:00:34 +0200
Subject: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <2435381.sM3CFAEXNR@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <5351858.jEb0qfTvrF@vostro.rjw.lan>
 <2f0e60e1-f429-2bd3-5f26-fd6199e64f34@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan>
Message-ID: <57767782.6020509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:

[ ... ]

>> GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
>> ACPI spec, I think it can stay in drivers/acpi/ from this point
>> of view, am I right?
>
> The question is not "Can it?", but "Does it need to?".
>
> It is in the spec, but still there's only one architecture needing it.
>
> There is no way to test it on any other architecture and no reason to build it
> for any other architecture, so why does it need to be located in drivers/acpi/ ?

Hi Rafael,

what is the problem of having it in drivers/acpi ?

There are cpufreq-dt, speedstep*, tegra124-* in drivers/cpufreq.

clocksource-probe which is DT based with different drivers using it in 
drivers/clocksource with a pletore of different archs.

Cstate code which is only used by x86 is in drivers/acpi, it is only 
used by x86/ia64 and it isn't a problem. There is a small chunk in 
arch/x86/kernel/acpi and it doesn't facilitate the comprehension of the 
code.

IMHO, having all ACPI code in the same directory will encourage the 
consolidation.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
