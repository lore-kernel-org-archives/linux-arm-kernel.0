From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Fri,  5 Dec 2014 11:38:38 +0800
Subject: [PATCH v4 0/4] ARM: hip04: add GPIO support
Message-ID: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
corresponding dts.

The 3/4 patch supports to find GPIO base number in increasing order,
if gpio-number-forward is defined in related dts nodes. If there are some
GPIO controllers in one Soc, all related GPIO dts node should contain
gpio-number-forward property. If not, error will come out.

Change in v4:
- Delete "default 128 if ARCH_HIP04" in arch/arm/Kconfig
- add a new patch to support find GPIO base number in increasing order
- add gpio-number-forward property in snps gpio binding doc
Change in v3:
- Move CONFIG_GPIO_DWAPB to hisi_defconfig
- Add CONFIG_GPIOLIB, CONFIG_GPIO_SYSFS in hisi_defconfig
Change in v2:
- Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig

Link for v3:
- http://www.spinics.net/lists/devicetree/msg60324.html

Zhou Wang (4):
  ARM: hip04: add GPIO configure in hisi_defconfig
  ARM: dts: hip04: add GPIO pieces
  gpio: Add find base in a increasing order
  Documentation: dt: gpio: Add gpio-number-forward property in snps
    gpio binding doc

 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |    2 +
 arch/arm/boot/dts/hip04.dtsi                       |   79 ++++++++++++++++++++
 arch/arm/configs/hisi_defconfig                    |    3 +
 drivers/gpio/gpiolib.c                             |   63 +++++++++++++---
 4 files changed, 138 insertions(+), 9 deletions(-)

-- 
1.7.9.5
