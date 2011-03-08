From: mike@compulab.co.il (Mike Rapoport)
Date: Tue,  8 Mar 2011 14:58:56 +0200
Subject: [PATCH 0/3] Harmony PCI-e and regulators
Message-ID: <cover.1299588456.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches provide update for Harmony PCI-e intialization and add
registration of the TPS65862 PMIC.
Additionally, there are several tegra_defconfig updates. These updates
allow booting the Harmony with PCI-e enabled and add ability to boot
TrimSlice with root on NFS.

The patches were generated vs. Olof's board-for-next-i2c that seems to
disappear. If there are now objection to these patches I can push them
into separate branch in my tree, so that it can be pulled after Tegra
I2C is merged.

Mike Rapoport (3):
  ARM: tegra: harmony: update PCI-e initialization sequence
  ARM: tegra: harmony: initialize the TPS65862 PMIC
  ARM: tegra: update defconfig

 arch/arm/configs/tegra_defconfig          |   12 ++-
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-harmony-pcie.c  |   24 ++++-
 arch/arm/mach-tegra/board-harmony-power.c |  161 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c       |    1 +
 arch/arm/mach-tegra/board-harmony.h       |    1 +
 6 files changed, 197 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-power.c

-- 
1.7.3.1
