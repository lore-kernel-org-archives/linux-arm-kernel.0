From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed,  2 Dec 2015 13:43:01 +0800
Subject: [PATCH v2 0/3] ACPI,
 clocksource: add GTDT and ARM memory-mapped timer support
Message-ID: <1449034984-12075-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patchset:
    (1)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
    Parse all kinds of timer in GTDT table of ACPI:arch timer,
    memory-mapped timer and SBSA Generic Watchdog timer.
    This driver can help to simplify all the relevant timer drivers,
    and separate all the ACPI GTDT knowledge from them.

    (2)Simplify ACPI code for arch timer in arm_arch_timer.c

    (3)Add memory-mapped timer support in arm_arch_timer.c

The SBSA Generic Watchdog info parsing support have been tested with
a upstreaming SBSA Generic Watchdog driver:
https://lkml.org/lkml/2015/10/27/466
on the following platforms:
    (1)ARM Foundation v8 model
    (2)AMD Seattle platform
    
ARM memory-mapped timer support of this patchset has been tested
on the following platforms:
    (1)ARM Foundation v8 model
    
Changelog:
v2: Rebase to latest kernel version(4.4-rc3).
    Fix the bug about the config problem,
    use CONFIG_ACPI_GTDT instead of CONFIG_ACPI in arm_arch_timer.c

v1: The first upstreaming version: https://lkml.org/lkml/2015/10/28/553

Fu Wei (3):
  ACPI: add GTDT table parse driver into ACPI driver
  clocksource: simplify ACPI code in arm_arch_timer.c
  clocksource: add memory-mapped timer support in arm_arch_timer.c

 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/gtdt.c                  | 367 +++++++++++++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c | 178 +++++++++++++----
 include/clocksource/arm_arch_timer.h |  19 ++
 include/linux/acpi.h                 |  17 ++
 6 files changed, 555 insertions(+), 36 deletions(-)
 create mode 100644 drivers/acpi/gtdt.c

-- 
2.5.0
