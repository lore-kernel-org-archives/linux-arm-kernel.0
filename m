From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 29 Jun 2016 23:32:16 +0200
Subject: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Message-ID: <CAJZ5v0iD5OYjp7ozmzoQ3zK-3+eMpdwzDxYgD=saLPjNeoq0Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 8:15 PM,  <fu.wei@linaro.org> wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer
>         1. Move some enums and marcos to header file
>         2. Add a new enum for spi type.
>         3. Improve printk relevant code
>
>     (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>     Parse all kinds of timer in GTDT table of ACPI:arch timer,
>     memory-mapped timer and SBSA Generic Watchdog timer.
>     This driver can help to simplify all the relevant timer drivers,
>     and separate all the ACPI GTDT knowledge from them.
>
>     (3)Simplify ACPI code for arm_arch_timer
>
>     (4)Add GTDT support for ARM memory-mapped timer

GTDT is ARM-specific AFAICS.

If so, why do we need that code to reside in drivers/acpi/ ?

Thanks,
Rafael
