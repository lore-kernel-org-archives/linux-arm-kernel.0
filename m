From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri,  3 Feb 2017 13:11:45 +0100
Subject: [PATCH v2 0/8] mmc: bcm2835: Add new driver for the sdhost controller
Message-ID: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Next version if the bcm2835 sdhost patch series.
New in this version:
 * DMA fixed.
 * updated docs (kconfig, file comment, commit message) clarifying
   the two sd controller situation.
 * some code cleanups, as pointed out by Stefan.
 * dt bindings use mmc at ... now.
 * added patches to update defconfigs.
 * added patch for rpi3 device tree, so wifi is actually enabled.

please review & test,
  Gerd

Eric Anholt (2):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835: Add new driver for the sdhost controller.

Gerd Hoffmann (6):
  mmc: bcm2835: add sdhost controller to devicetree
  arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig
  arm: set CONFIG_MMC_BCM2835=y in multi_v7_defconfig
  arm64: set CONFIG_MMC_BCM2835=y in defconfig
  ARM: dts: bcm283x: switch from &sdhci to &sdhost
  ARM: dts: bcm2837: add &sdhci and &sdhost

 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   24 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    6 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   10 +
 arch/arm/configs/bcm2835_defconfig                 |    1 +
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   |   17 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/mmc/host/Kconfig                           |   14 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835.c                         | 1521 ++++++++++++++++++++
 10 files changed, 1596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835.c

-- 
1.8.3.1
