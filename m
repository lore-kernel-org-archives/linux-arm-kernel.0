From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  5 Feb 2013 20:55:12 +0100
Subject: [PATCH v5 0/3] Kirkwoode cpufreq driver
Message-ID: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.

The changes to kirkwood_defconfig enable it and set the default
governor to ondemand.

Changes since v4:

Add DT cpus/cpu at 0 node with needed clocks.
Add documentation of this DT node.

Changes since v3:

Check return value of of_find_compatible_node()
Return -EADDRNOTAVAIL when devm_request_and_ioremap() fails.
Remove default: clause.
Made .name consistent.

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

 Documentation/devicetree/bindings/arm/kirkwood.txt |   27 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   13 +
 arch/arm/configs/kirkwood_defconfig                |    3 +
 arch/arm/mach-kirkwood/board-dt.c                  |    3 +-
 arch/arm/mach-kirkwood/common.c                    |   23 ++
 arch/arm/mach-kirkwood/common.h                    |    2 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |    2 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |    1 +
 drivers/cpufreq/Kconfig.arm                        |    6 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/kirkwood-cpufreq.c                 |  259 ++++++++++++++++++++
 12 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/kirkwood.txt
 create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c

-- 
1.7.10.4
