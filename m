From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  4 Dec 2013 15:17:17 +0100
Subject: [PATCH v4 0/4] Dove cpufreq driver
Message-ID: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a cpufreq driver for Dove.

The patchset is based on Rafael's linux-next branch from yesterday.
Quite likely Jason Cooper will take patches 2-3 via the mvebu tree,
but i will let you decide on that.

For version 3 there was a comment that the device tree binding should
be reviewed, and Viresh offered to do that. The binding is identical
to the kirkwood binding, with the addition that Dove requires an
interrupt handler, so the binding also lists this interrupt, using the
standard DT properties for interrupts.

Andrew Lunn (4):
  cpufreq: Add a cpufreq driver for Marvell Dove
  mvebu: Dove: Instantiate cpufreq driver.
  mvebu: Dove: Enable cpufreq driver in defconfig
  mvebu: Dove: Add clocks and DFS interrupt to cpu node in DT.

 arch/arm/Kconfig                       |   1 +
 arch/arm/boot/dts/dove.dtsi            |   4 +
 arch/arm/configs/dove_defconfig        |   2 +
 arch/arm/mach-dove/board-dt.c          |   3 +
 arch/arm/mach-dove/common.c            |  36 +++++
 arch/arm/mach-dove/common.h            |   1 +
 arch/arm/mach-dove/include/mach/dove.h |   1 +
 drivers/cpufreq/Kconfig.arm            |   5 +
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/dove-cpufreq.c         | 259 +++++++++++++++++++++++++++++++++
 10 files changed, 313 insertions(+)
 create mode 100644 drivers/cpufreq/dove-cpufreq.c

-- 
1.8.5
