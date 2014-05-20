From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 10:11:41 +0900
Subject: [GIT PULL 4/5] Samsung DT updates for 3.16
Message-ID: <014701cf73c8$752a65c0$5f7f3140$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt

for you to fetch changes up to b5839bd87f197e133a0025c36df286eab6e1d858:

  ARM: dts: Add MFC memory banks to exynos5420 boards (2014-05-20 01:04:13
+0900)

----------------------------------------------------------------
Samsung DT updates for v3.16

- exynos4
  : add missing pinctrls

- exynos4412-trats2
  : update camera nodes and add rear camera nodes
  : rename alias for i2c_ak8975 label
  Update camera nodes for exynos4 and exynos4412-trats2

- exynos5250
  : update DWC3 usb controller and enable to use generic USB DRD phy

- exynos5250-snow
  : enable dp-controller, fimd, hdmi and pwm backlight
  : add sound node and Vbus regulator for USB 3.0
  : add tps65090 power regulator
  : add pinctrl for EC irq and i2c-arbitrator

- exynos5420
  : change to correct compatible string for hdmi
  : add PD entry to MFC codec and enable DWC3 and USB 3.0 PHY
  : add MFC memory banks for smdk5420 and arndale-octa boards

- exynos5420-peach-pit
  : add support exynos5420 based peach-pit board
  : add sound node and Vbus regulatro for USB 3.0
  : enable dp-controller, fimd

- exynos5420-smdk5420
  : add Vbus regulatro for USB 3.0

- use generic DT bindings for map SYSRAM

----------------------------------------------------------------
Ajay Kumar (2):
      ARM: dts: Add pwmX_out pinctrl nodes to exynos5250
      ARM: dts: enable pwm backlight for exynos5250-snow

Arun Kumar K (3):
      ARM: dts: Add pwmX_out pinctrl nodes to exynos5420
      ARM: dts: Add node labels to exynos5420
      ARM: dts: Add exynos5420 peach-pit board support

Doug Anderson (3):
      ARM: dts: add pinctrl for i2c-arbitrator of exynos5250-snow
      ARM: dts: add pinctrl for EC irq of exynos5250-snow
      ARM: dts: add tps65090 power regulator for exynos5250-snow

Rahul Sharma (7):
      ARM: dts: enable hdmi for exynos5250 based snow board
      ARM: dts: change to correct compatible string for exynos5420 hdmi
      ARM: dts: enable hdmi for exynos5420-peach-pit board
      ARM: dts: enable fimd for exynos5250-snow board
      ARM: dts: enable dp-controller for exynos5250-snow board
      ARM: dts: enable fimd for exynos5420 based peach-pit board
      ARM: dts: enable dp-controller for exynos5420-peach-pit board

Sachin Kamat (4):
      ARM: EXYNOS: Map SYSRAM through generic DT bindings
      devicetree: bindings: document SYSRAM binding
      ARM: dts: Add PD entry to MFC codec on exynos5420
      ARM: dts: Add MFC memory banks to exynos5420 boards

Sylwester Nawrocki (2):
      ARM: dts: Update camera nodes for exynos4 and exynos4412-trats2
      ARM: dts: Add rear camera nodes for exynos4412-trats2

Tomasz Stanislawski (2):
      ARM: dts: add missing pinctrls for I2C of exynos4
      ARM: dts: rename alias for i2c_ak8975 label for exynos4412-trats2

Tushar Behera (2):
      ARM: dts: Add sound node for exynos5250-snow board
      ARM: dts: Add sound node for exynos5420-peach-pit board

Vivek Gautam (7):
      ARM: dts: Enable support for USB 3.0 PHY controller for exynos5420
      ARM: dts: Enable support for DWC3 controller for exynos5420
      ARM: dts: Enable support for generic USB DRD phy for exynos5250
      ARM: dts: Update DWC3 usb controller to use new phy driver for
exynos5250
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5250-snow
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5420-peach-pit
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5420-smdk5420

 .../devicetree/bindings/arm/exynos/smp-sysram.txt  |   38 +++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   18 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   15 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   18 ++
 arch/arm/boot/dts/exynos4412-trats2.dts            |   79 +++++-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   18 ++
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   28 ++
 arch/arm/boot/dts/exynos5250-snow.dts              |  224 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |   38 ++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    5 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  287
++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   28 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   51 ++++
 arch/arm/boot/dts/exynos5420.dtsi                  |  106 +++++++-
 arch/arm/mach-exynos/common.h                      |    1 +
 arch/arm/mach-exynos/exynos.c                      |   64 -----
 arch/arm/mach-exynos/firmware.c                    |    8 +-
 arch/arm/mach-exynos/include/mach/map.h            |    7 -
 arch/arm/mach-exynos/platsmp.c                     |   56 +++-
 22 files changed, 984 insertions(+), 113 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/exynos/smp-sysram.txt
 create mode 100644 arch/arm/boot/dts/exynos5420-peach-pit.dts
