From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 19 Oct 2013 14:37:37 +0200
Subject: [PATCH 0/4] Dove cpufreq driver
Message-ID: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Dove can run its CPU at two different frequencies. Add a
cpufreq driver.

These patches are based on top of Rafael's for-next branch, since
there have been a lot of changes to the cpufreq core code.

However, this driver also has a run time dependency on the PMU
interrupt controller patches:

http://www.spinics.net/lists/devicetree/msg06547.html

If the PMU interrupt controller is not available, the cpufreq probe
function will fail, but the machine keeps running O.K.

Probably Jason will want to take the mvebu patches, and Rafeal or
Viresh for the cpufreq driver itself.

Once github comes back online, the following branch will have these patches
and the dependencies.

https://github.com/lunn/linux v3.12-rc5-rafael-next-dove-cpufreq

Andrew

Andrew Lunn (4):
  cpufreq: Add a cpufreq driver for Marvell Dove
  mvebu: Dove: Instantiate cpufreq driver.
  mvebu: Dove: Enable cpufreq driver in defconfig
  mvebu: Dove: Add clocks and DFS interrupt to cpu node in DT.

 arch/arm/Kconfig                       |   1 +
 arch/arm/boot/dts/dove.dtsi            |   4 +
 arch/arm/configs/dove_defconfig        |   2 +
 arch/arm/mach-dove/board-dt.c          |   2 +
 arch/arm/mach-dove/common.c            |  36 +++++
 arch/arm/mach-dove/common.h            |   1 +
 arch/arm/mach-dove/include/mach/dove.h |   1 +
 drivers/cpufreq/Kconfig.arm            |   7 +
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/dove-cpufreq.c         | 276 +++++++++++++++++++++++++++++++++
 10 files changed, 331 insertions(+)
 create mode 100644 drivers/cpufreq/dove-cpufreq.c

-- 
1.8.4.rc3
