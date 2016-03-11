From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Mar 2016 11:54:59 -0800
Subject: [GIT PULL] ARM: SoC: Two more fixes for 4.5
Message-ID: <20160311195459.GA24769@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit f3c87e99f401a0ff0ef941346ec6e790f0fd526e:

  Merge tag 'renesas-dt-fixes2-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2016-03-02 23:24:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to d7d5a43c0d16760f25d892bf9329848167a8b8a4:

  ARM: mvebu: fix overlap of Crypto SRAM with PCIe memory window (2016-03-11 11:49:55 -0800)

----------------------------------------------------------------
ARM: SoC fixes

Two more fixes for 4.5:

 - One is a fix for OMAP that is urgently needed to avoid DRA7xx chips from
   premature aging, by always keeping the Ethernet clock enabled.

 - The other solves a I/O memory layout issue on Armada, where SROM and PCI
   memory windows were conflicting in some configurations.

----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property

Mugunthan V N (1):
      ARM: dts: dra7: do not gate cpsw clock due to errata i877

Olof Johansson (1):
      Merge tag 'for-v4.5-rc/omap-critical-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into fixes

Thomas Petazzoni (1):
      ARM: mvebu: fix overlap of Crypto SRAM with PCIe memory window

 Documentation/devicetree/bindings/arm/omap/omap.txt |  1 +
 arch/arm/boot/dts/armada-xp-axpwifiap.dts           |  4 ++--
 arch/arm/boot/dts/armada-xp-db.dts                  |  4 ++--
 arch/arm/boot/dts/armada-xp-gp.dts                  |  4 ++--
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts     |  4 ++--
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts       |  4 ++--
 arch/arm/boot/dts/armada-xp-matrix.dts              |  4 ++--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts      |  4 ++--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts    |  6 +++---
 arch/arm/boot/dts/armada-xp-synology-ds414.dts      |  4 ++--
 arch/arm/boot/dts/dra7.dtsi                         | 10 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.c                    |  9 ++++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    |  3 +++
 13 files changed, 41 insertions(+), 20 deletions(-)
