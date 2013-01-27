From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 11:07:21 +0100
Subject: [PATCH v3 0/3] Kirkwoode cpufreq driver
Message-ID: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.

The changes to kirkwood_defconfig enable it and set the default
governor to ondemand.

Changes since v2:

Remove unneeded #include file left over from debugging.
WARN_ON(1) instead of dev_err() for unexpected state
Various blank lines removed.
Reformat comment.
writel -> writel_relaxed

Changes since v1:

tabify Kconfig.arm entry
Sort order of include files
Remove some unnecassary include files
Reformat multiline comment to be coding style conform.

Andrew Lunn (3):
  cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs
  arm: kirkwood: Instantiate cpufreq driver
  arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig

 arch/arm/Kconfig                                  |    1 +
 arch/arm/configs/kirkwood_defconfig               |    3 +
 arch/arm/mach-kirkwood/board-dt.c                 |    3 +-
 arch/arm/mach-kirkwood/common.c                   |   23 ++
 arch/arm/mach-kirkwood/common.h                   |    2 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    2 +
 drivers/clk/mvebu/clk-gating-ctrl.c               |    1 +
 drivers/cpufreq/Kconfig.arm                       |    6 +
 drivers/cpufreq/Makefile                          |    1 +
 drivers/cpufreq/kirkwood-cpufreq.c                |  264 +++++++++++++++++++++
 10 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c

-- 
1.7.10.4
