From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Nov 2016 10:47:29 +0100
Subject: [PATCH v16 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
Message-ID: <20161117094729.GB2155@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 09:48:53PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Move some enums and marcos to header file;
>         2. Add a new enum for spi type;
>         3. Improve printk relevant code.
>         4. rename some  enums and defines, and some cleanups.
>         5. separate out arch_timer_uses_ppi init code and fix a potential bug
>         6. Refactor arch_timer_detect_rate to keep dt code only in *_of_init
>         7. Refactor arch_timer_needs_probing, and call it only if acpi disabled.
>         8. Introduce some new structs and refactor the timer init code
> 
>     (2)Introduce ACPI GTDT parser: drivers/acpi/arm64/acpi_gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
> 
>     (3)Simplify ACPI code for arm_arch_timer
> 
>     (4)Add GTDT support for ARM memory-mapped timer, also refactor
>     original memory-mapped timer dt support for reusing some common
>     code.
> 
> This patchset has been tested on the following platforms with ACPI enabled:
>     (1)ARM Foundation v8 model
> 
> Changelog:
> v16: https://lkml.org/lkml/2016/
>      Fix patchset problem about static enum ppi_nr of 01/13 in v15.
>      Refactor arch_timer_detect_rate.
>      Refactor arch_timer_needs_probing.

Most of the patches are touching drivers/clocksource and others acpi.

Through which tree this patchset should go ?
