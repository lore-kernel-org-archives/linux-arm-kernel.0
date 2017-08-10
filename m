From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Aug 2017 14:52:17 +0200
Subject: [PATCH 0/4] Switch Ux500 to use generic DT cpufreq
Message-ID: <20170810125221.25818-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series switches the Ux500 over to use the generic DT cpufreq.
A pretty nice cleanup.

Merge plan:

- Merge patch 1/4 into ARM SoC DTS branches separately.

- Merge the remaining three patches into the cpufreq tree
  with Lee's ACK on the second (MFD) patch.

This should make for a clean transition for v4.14.

Linus Walleij (4):
  ARM: dts: augment Ux500 to use DT cpufreq
  cpufreq: enable the DT cpufreq driver on the Ux500
  mfd: db8500-prcmu: Get rid of cpufreq dependency
  cpufreq: dbx500: Delete obsolete driver

 arch/arm/boot/dts/ste-dbx5x0.dtsi    |  15 ++---
 arch/arm/mach-ux500/Kconfig          |   1 +
 drivers/cpufreq/Kconfig.arm          |   9 ---
 drivers/cpufreq/Makefile             |   1 -
 drivers/cpufreq/cpufreq-dt-platdev.c |   5 ++
 drivers/cpufreq/dbx500-cpufreq.c     | 103 -----------------------------------
 drivers/mfd/db8500-prcmu.c           |  59 ++++++--------------
 7 files changed, 31 insertions(+), 162 deletions(-)
 delete mode 100644 drivers/cpufreq/dbx500-cpufreq.c

-- 
2.9.4
