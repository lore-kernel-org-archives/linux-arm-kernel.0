From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  1 Apr 2014 16:03:42 +0800
Subject: [PATCH v1 0/8] support Hisilicon HiP04
Message-ID: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC with MCPM implementation.

Haojian Zhuang (8):
  ARM: debug: add HiP04 debug uart
  ARM: hisi: add ARCH_HISI
  irq: gic: use mask field in GICC_IAR
  irq: gic: extends the cpu interface to 16
  ARM: mcpm: change max clusters to 4
  ARM: hisi: add hip04 SoC support
  ARM: dts: add hip04-d01 dts file
  ARM: config: append hip04_defconfig

 arch/arm/Kconfig                 |   2 +-
 arch/arm/Kconfig.debug           |  10 ++
 arch/arm/Makefile                |   2 +-
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/hip04-d01.dts  |  74 +++++++++++
 arch/arm/boot/dts/hip04.dtsi     | 240 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hip04_defconfig |  64 ++++++++++
 arch/arm/include/asm/mcpm.h      |   2 +-
 arch/arm/mach-hisi/Kconfig       |  26 +++-
 arch/arm/mach-hisi/core.h        |   6 +
 arch/arm/mach-hisi/hisilicon.c   |  17 +++
 arch/arm/mach-hisi/platsmp.c     | 257 +++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c        |  80 +++++++-----
 include/linux/irqchip/arm-gic.h  |   2 +
 14 files changed, 746 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 create mode 100644 arch/arm/configs/hip04_defconfig

-- 
1.8.3.2
