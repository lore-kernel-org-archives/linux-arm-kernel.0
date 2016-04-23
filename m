From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Apr 2016 12:58:57 -0700
Subject: [GIT PULL 1/4] Broadcom devicetree changes for 4.7
Message-ID: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.7/devicetree

for you to fetch changes up to 3db62afd11738f896ef83132022a40be74961860:

  Merge tag 'bcm2835-dt-next-2016-04-20' into devicetree/next (2016-04-22 12:22:04 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC Device Tree changes:

- Rafal adds proper VCC GPIO to be fed to the USB host controllers for known
  BCM5301x devices needing that, he also enables earlycon, and enables the
  SPI-NOR flashes on relevant devices

- Eric adds the VideoCore 4 Device Tree nodes to the BCM283x Device Tree and
  provides a DRM patch to kick out the simplefb framebuffer to avoid conflicts

- Stephan adds proper CPU nodes for the ARM processor on the BCM2835 SoC Device
  Tree

- Martin provides a binding fix for the DMA channel interrupt numbers and
  description

----------------------------------------------------------------
Eric Anholt (2):
      drm/vc4: Kick out the simplefb framebuffer before we set up KMS.
      ARM: bcm2835: Add VC4 to the device tree.

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2016-04-20' into devicetree/next

Martin Sperl (1):
      dt/bindings: bcm2835: correct description for DMA-int

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Set vcc-gpio for USB controllers of few devices
      ARM: BCM5301X: Enable earlycon on tested devices
      ARM: BCM5301X: Add DT entry for SPI controller and NOR flash

Stefan Wahren (1):
      ARM: bcm2835: add CPU node for ARM core

 .../brcm,bcm2835-armctrl-ic.txt                    |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  9 +++++
 arch/arm/boot/dts/bcm2835.dtsi                     | 11 +++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  4 ++
 arch/arm/boot/dts/bcm283x.dtsi                     | 47 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 10 ++++-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  6 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 17 +++-----
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  6 ++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  2 +-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |  5 +++
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        |  8 ++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  6 ++-
 arch/arm/boot/dts/bcm5301x.dtsi                    | 32 +++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c                      | 20 +++++++++
 20 files changed, 188 insertions(+), 19 deletions(-)
