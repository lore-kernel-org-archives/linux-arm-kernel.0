From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 4 Jul 2016 15:43:50 +0200
Subject: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <1643662.QIDsTbCMZg@vostro.rjw.lan>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan> <57767782.6020509@linaro.org>
 <1643662.QIDsTbCMZg@vostro.rjw.lan>
Message-ID: <577A6816.3050709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2016 11:01 PM, Rafael J. Wysocki wrote:
> On Friday, July 01, 2016 04:00:34 PM Daniel Lezcano wrote:
>> On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:
>>

[ ... ]

>> clocksource-probe which is DT based with different drivers using it in 
>> drivers/clocksource with a pletore of different archs.
> 
> So maybe the GTDT code should be there too?

*maybe*

>> Cstate code which is only used by x86 is in drivers/acpi, it is only 
>> used by x86/ia64 and it isn't a problem.
> 
> It is a problem.  

Can you explain why it is a problem ?

> drivers/acpi/ is not the right place for arch-specific code.

I do not understand this assertion regarding what happened during the
last years with different subsystems where the drivers were moved from
their arch specific directories to the drivers directory (cpufreq,
cpuidle, clockevent, clk, etc ...) and resulted at the end to a code
refactoring and consolidation.

Why ACPI should follow the opposite rule ?

>> There is a small chunk in arch/x86/kernel/acpi and it doesn't facilitate the
>> comprehension of the code.
>>
>> IMHO, having all ACPI code in the same directory will encourage the 
>> consolidation.
> 
> The consolidation of what exactly?

The consolidation of the ACPI code in general which is the
counter-example of self-contained code.

> In particular, how does the GTDT code in drivers/acpi/ help to consolidate
> anything?

If I imagine we group all ACPI code under a common directory, the first
example coming in my mind is the sharing of private headers, reducing
the scope of exported functions and global variables (eg. acpi_disabled).

That say, I can understand grouping all the ACPI into a single directory
will make it fall under a single umbrella's maintainer and that could be
a nightmare to maintain as it covers a lot of different features.
However, I believe that could be solved by clearly identifying who takes
care of what.



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
