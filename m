From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue,  7 Jun 2016 13:05:38 +0200
Subject: [PATCH v3 00/10] raspberry pi 3 patch series, part 1: essentials
Message-ID: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Raspberry pi 3 patches, next round.  Should be pretty much ready
to go now.

Changes v3:
 * redo defconfig update, drop DRM_VC4=y for now (not working for me).
 * split rpi3 device tree patch into two again (arm64 + arm).

Changes v2:
 * send essential patches only
 * dropped ARCH_BCM kconfig option.
 * drop include hack for rpi3 device tree in arm.
 * drop DMA offset patch, pick up the version from Alex instead.

Patches are also available from:
  git://git.kraxel.org/linux bcm2837-47-v3

Note that the git branch has the complete set of patches (including
device tree patches and rpi3 wifi).

cheers,
  Gerd

Alexander Graf (1):
  arm64: Allow for different DMA and CPU bus offsets

Eric Anholt (4):
  irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ.
  arm64: Add platform selection for BCM2835.
  dt-bindings: Add root properties for Raspberry Pi 3
  ARM: bcm2835: Add devicetree for the Raspberry Pi 3.

Gerd Hoffmann (4):
  pinctrl: walk into bcm subdir unconditionally
  arm64: Add BCM2835 support to the defconfig.
  ARM: bcm2835: Add devicetree for the Raspberry Pi 3, for arm (32)
  ARM: bcm2837: dt: Add the ethernet to the device trees

Lubomir Rintel (1):
  ARM: bcm2835: dt: Add the ethernet to the device trees

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  4 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  1 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        | 19 ++++++
 arch/arm/boot/dts/bcm283x.dtsi                     |  2 +
 arch/arm64/Kconfig.platforms                       | 13 ++++
 arch/arm64/boot/dts/broadcom/Makefile              |  1 +
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   | 30 +++++++++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          | 74 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       | 12 ++++
 arch/arm64/include/asm/dma-mapping.h               | 17 ++++-
 drivers/irqchip/irq-bcm2835.c                      |  3 +-
 drivers/irqchip/irq-bcm2836.c                      |  2 +-
 drivers/pinctrl/Makefile                           |  2 +-
 18 files changed, 198 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837.dtsi

-- 
1.8.3.1
