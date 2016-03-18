From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Mar 2016 14:37:41 +0100
Subject: [RESEND PATCH v4 0/5] acpi, clocksource: add GTDT and ARM
 memory-mapped timer support
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Message-ID: <56EC04A5.2030106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2016 09:00 AM, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>      (1)Move some enums and marcos to header file for arm_arch_timer,
>      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c
>
>      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>      memory-mapped timer and SBSA Generic Watchdog timer.
>      This driver can help to simplify all the relevant timer drivers,
>      and separate all the ACPI GTDT knowledge from them.
>
>      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>      (4)Add memory-mapped timer support in arm_arch_timer.c
>
> RESEND:
>     -- Corrected Cc list: added missing mailing lists

Hi Fu Wei,

the whole series is lacking to encapsulate the ACPI code.

I believe Marc Zyngier did a first effort to make the ACPI self 
contained and this series ignore that.

Please rework the series in the direction no acpi gtdt structure appears 
in the driver.

Thanks

   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
