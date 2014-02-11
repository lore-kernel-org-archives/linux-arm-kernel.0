From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:10:24 +0000
Subject: [PATCH 00/12] Versatile Express updates
Message-ID: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a set of updates following the infrastructure
rework and depends on it. It will be finally posted once
the main series is merged. For the time being I would really
appreciate feedback and/or (n)acks...

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net> 
Cc: lm-sensors at lm-sensors.org

Pawel Moll (11):
  misc: vexpress-syscfg: Add udelay-based delay
  power/reset: vexpress: Use udelay instead of timers
  clk: versatile: Split config options for sp810 and vexpress_osc
  clocksource: Sched clock source for Versatile Express
  GPIO: gpio-generic: Add label to platform data
  mfd: vexpress-sysreg: Add labels to gpio banks
  mfd: syscon: Consider platform data a regmap config name
  mfd: vexpress-sysreg: Add syscon labels as platform data
  hwmon: vexpress: Use devm helper for hwmon device registration
  ARM: vexpress: Simplify SMP operations for DT-powered system
  ARM: vexpress: move HBI check to sysreg driver

Sudeep KarkadaNagesha (1):
  ARM: vexpress: remove redundant vexpress_dt_cpus_num to get cpu count

 arch/arm/mach-vexpress/core.h           |   3 +-
 arch/arm/mach-vexpress/platsmp.c        | 187 +++++++-------------------------
 arch/arm/mach-vexpress/v2m.c            |  57 +---------
 drivers/clk/Kconfig                     |   9 +-
 drivers/clk/versatile/Kconfig           |  26 +++++
 drivers/clk/versatile/Makefile          |   5 +-
 drivers/clocksource/Kconfig             |   9 ++
 drivers/clocksource/Makefile            |   1 +
 drivers/clocksource/vexpress.c          |  40 +++++++
 drivers/gpio/gpio-generic.c             |   2 +
 drivers/hwmon/vexpress.c                | 100 +++++------------
 drivers/mfd/syscon.c                    |   1 +
 drivers/mfd/vexpress-sysreg.c           |  45 ++++----
 drivers/misc/vexpress-syscfg.c          |  40 ++++++-
 drivers/power/reset/vexpress-poweroff.c |  10 +-
 include/linux/basic_mmio_gpio.h         |   1 +
 include/linux/vexpress.h                |   1 -
 17 files changed, 216 insertions(+), 321 deletions(-)
 create mode 100644 drivers/clk/versatile/Kconfig
 create mode 100644 drivers/clocksource/vexpress.c

-- 
1.8.3.2
