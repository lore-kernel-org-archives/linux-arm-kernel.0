From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 5 Aug 2012 23:05:17 +0800
Subject: [PATCH v2 0/4] Add a generic cpufreq-cpu0 driver
Message-ID: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Rebase on v3.6-rc1
* Add a patch introducing regulator_set_voltage_tol()
* Address review comments on v1

Richard Zhao (1):
  ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp

Shawn Guo (3):
  PM / OPP: Initialize OPP table from device tree
  regulator: add a new API regulator_set_voltage_tol()
  cpufreq: Add a generic cpufreq-cpu0 driver

 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |   55 ++++
 Documentation/devicetree/bindings/power/opp.txt    |   25 ++
 arch/arm/kernel/smp.c                              |   54 ++++
 drivers/base/power/opp.c                           |   65 +++++
 drivers/cpufreq/Kconfig                            |   11 +
 drivers/cpufreq/Makefile                           |    2 +
 drivers/cpufreq/cpufreq-cpu0.c                     |  271 ++++++++++++++++++++
 include/linux/opp.h                                |    8 +
 include/linux/regulator/consumer.h                 |    7 +
 9 files changed, 498 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
 create mode 100644 Documentation/devicetree/bindings/power/opp.txt
 create mode 100644 drivers/cpufreq/cpufreq-cpu0.c

-- 
1.7.5.4
