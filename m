From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:41:15 +0200
Subject: [PATCH v2 0/3] ARM: mvebu: enable SDHCI interface on Armada 38x
Message-ID: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Gregory, Andrew, Sebastian,

Here is a small set of patches that enable the SDHCI interface on
Armada 38x. The first one adds the DT details, the second and third
ones adjusts the appropriate defconfigs to include the relevant
driver.

The sdhci-pxav3 driver change has been taken by the MMC maintainer
Chris Ball, and is already in 3.15-rc1.

Changes since v1:

 * Rebased on top of v3.15-rc1.

 * Split in two commits the defconfig changes, so that the
   multi_v7_defconfig change can be directly taken by the arm-soc
   maintainers.

Thanks!

Thomas

Thomas Petazzoni (3):
  ARM: mvebu: enable the SDHCI interface on Armada 385
  ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the mvebu_v7_defconfig
  ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the multi_v7_defconfig

 arch/arm/boot/dts/armada-385-db.dts | 8 ++++++++
 arch/arm/boot/dts/armada-38x.dtsi   | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 4 files changed, 19 insertions(+)

-- 
1.8.3.2
