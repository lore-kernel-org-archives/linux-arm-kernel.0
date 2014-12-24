From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 24 Dec 2014 17:23:34 +0800
Subject: [PATCH v5 0/2] ARM: hip04: add GPIO support
Message-ID: <1419413016-31932-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
corresponding dts. The default value of ARCH_NR_GPIOS is used to find gpio
base here.

Change in v5:
- Base on v3.19-rc1
- Just use default value of ARCH_NR_GPIOS to find gpio base. Remove the new
  added patch(3/4) in v4.
Change in v4:
- Delete "default 128 if ARCH_HIP04" in arch/arm/Kconfig
- add a new patch to support find GPIO base number in increasing order
- add gpio-number-forward property in snps gpio binding doc
Change in v3:
- Move CONFIG_GPIO_DWAPB to hisi_defconfig
- Add CONFIG_GPIOLIB, CONFIG_GPIO_SYSFS in hisi_defconfig
Change in v2:
- Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig

Link for v4:
- http://www.spinics.net/lists/arm-kernel/msg383883.html
Link for v3:
- http://www.spinics.net/lists/devicetree/msg60324.html

Zhou Wang (2):
  ARM: hip04: add GPIO configure in hisi_defconfig
  ARM: dts: hip04: add GPIO pieces

 arch/arm/boot/dts/hip04.dtsi    |   77 +++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig |    1 +
 2 files changed, 78 insertions(+)

-- 
1.7.9.5
