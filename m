From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 17:38:29 +0200
Subject: [PATCH v2 0/4] ARM64: marvell: improve support for Armada 7K/8K
Message-ID: <1460648313-31642-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches improve the support for Marvell Armada
7K/8K. Please wait for the clock DT bindings and PCIe DT bindings to
be Acked-by before merging.

The first two patches adjust the existing Device Tree to use the newly
proposed DT bindings to describe the AP806 clocks.

The last two patches add Device Tree description for a few IPs in the
CP110 HW block: one of its system controller, and the PCIe
controllers.

Changes since v1:

 - Update the CP110 system controller DT description to the latest
   binding (no more gate-clock-indices), slightly different list of
   clocks.

 - Update the CP110 PCIe controller DT description to the latest DT
   binding (only one clock needed instead of two).

Thanks!

Thomas

Thomas Petazzoni (4):
  arm64: marvell: enable AP806 and CP110 syscon driver
  arm64: dts: marvell: use new clock binding on Armada AP806
  arm64: dts: marvell: initial DT description of Armada 7K/8K CP110
    master
  arm64: dts: marvell: enable one PCIe interface on Armada 7040-DB

 arch/arm64/Kconfig.platforms                       |   4 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   6 +
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  34 ++---
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 140 +++++++++++++++++++++
 8 files changed, 162 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi

-- 
2.6.4
