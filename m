From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 09:53:05 +0900
Subject: [GIT PULL 5/5] Samsung DT updates for v3.17
Message-ID: <53C9C171.4090208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt

for you to fetch changes up to ccaba4527156da1619a23bafcb944e8e029d0573:

   ARM: dts: Add I2S dt node for exynos3250 (2014-07-19 04:10:44 +0900)

----------------------------------------------------------------
Samsung DT updates for v3.17

exynos3250: add i2s dt for audio interface

exynos4
  - cleanup arm-pmu node because of 4 pmu on
    exynos4412 but 2 pmu on other exynos4 SoCs
  - add support sub-nodes to exynos usb host for exynos4

exynos4412-odroid-common
  - fix T-FLASH hotplug detection
  - disable 'always on' for BUCK8
  - add support for GPIO based buttons
  - add MAX98090 audio codec

exynos4412-odroidx2 and exynos4412-odroidu3
- refactor exynos4412-odroidx and exynos4412-odroid-common
   for odroid-x2 and u2/u3

exynos4412-odroidx
  - add support for USB phy, host and device
  - enable common hardware blocks, secure firmware calls,
    watchdog, g2d and fimc (mem2mem) multimedia accelerators
  - add support for USB phy, host and device
  - correct memory size

exynos5410
  - fill in CPU clock-frequency property to avoid warning

exynos5420
  - remove display pd because of instability

exynos5420-peach-pit and exynos5800-peach-pi
  - sort nodes each other to check its differences easily
  - enable audio support and add sound-card name property
  - add mask-tpm-reset node
  - add cros_ec including keyboard, i2c tunnel and tps65090
    and battery under the i2c tunnel

----------------------------------------------------------------
Andreas Faerber (1):
       ARM: dts: Fill in CPU clock-frequency for exynos5410

Chanho Park (1):
       ARM: dts: clean up arm-pmu node for exynos4

Doug Anderson (2):
       ARM: dts: Add mask-tpm-reset node in exynos5420-peach-pit
       ARM: dts: Add cros_ec to exynos5420-peach-pit and exynos5800-peach-pi

Kamil Debski (2):
       ARM: dts: add support for USB phy, host and device for 
exynos4412-odroidx
       ARM: dts: disable 'always on' for BUCK8 regulator for 
exynos4412-odroid-common

Marek Szyprowski (6):
       ARM: dts: add port sub-nodes to exynos usb host modules for exynos4
       ARM: dts: enable common hardware blocks for exynos4412-odroidx
       ARM: dts: correct memory size for exynos4412-odroidx
       ARM: dts: refactor Odroid DTS file and add support for Odroid X2 
and U2/U3
       ARM: dts: add support for GPIO buttons for exynos4412-odroid
       ARM: dts: fix T-FLASH hotplug detection for exynos4412-odroid-common

Rahul Sharma (1):
       ARM: dts: remove display power domain for exynos5420

Sylwester Nawrocki (1):
       ARM: dts: Add sound nodes for Odroid-X2/U3 boards

Tomasz Figa (1):
       ARM: dts: Add I2S dt node for exynos3250

Tushar Behera (3):
       ARM: dts: Enable audio support for exynos5800-peach-pi
       ARM: dts: Sort nodes within Peach-pit/Peach-pi dts files
       ARM: dts: Add sound-card name for Snow/Peach-Pit/Peach-Pi

Vikas Sajjan (1):
       ARM: dts: Add mask-tpm-reset node in exynos5800-peach-pi

  arch/arm/boot/dts/Makefile                      |   2 +
  arch/arm/boot/dts/exynos3250.dtsi               |  13 +
  arch/arm/boot/dts/exynos4.dtsi                  |  30 ++
  arch/arm/boot/dts/exynos4210.dtsi               |   6 -
  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 371 
++++++++++++++++++++++
  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  61 ++++
  arch/arm/boot/dts/exynos4412-odroidx.dts        | 279 ++---------------
  arch/arm/boot/dts/exynos4412-odroidx2.dts       |  32 ++
  arch/arm/boot/dts/exynos4412.dtsi               |   4 +
  arch/arm/boot/dts/exynos4x12.dtsi               |   6 -
  arch/arm/boot/dts/exynos5250-snow.dts           |   1 +
  arch/arm/boot/dts/exynos5410.dtsi               |   4 +
  arch/arm/boot/dts/exynos5420-peach-pit.dts      | 392 
+++++++++++++++++-------
  arch/arm/boot/dts/exynos5420.dtsi               |   6 -
  arch/arm/boot/dts/exynos5800-peach-pi.dts       | 374 
++++++++++++++++------
  15 files changed, 1106 insertions(+), 475 deletions(-)
  create mode 100644 arch/arm/boot/dts/exynos4412-odroid-common.dtsi
  create mode 100644 arch/arm/boot/dts/exynos4412-odroidu3.dts
  create mode 100644 arch/arm/boot/dts/exynos4412-odroidx2.dts
