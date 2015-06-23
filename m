From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 23 Jun 2015 18:50:00 +0300
Subject: [PATCH 0/4] [New SoC] Add support for RC Module's K1879XB1YA
Message-ID: <1435074604-19312-1-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the very basic support for RC Module's K1879XB1YA SoC 
and MB77.07 Reference Design. It is currently tested against 4.1-rc8

The K1879XB1YA is a hybrid SoC featuring one ARM1176JZF-S Core, one 
NeuroMatrix DSP Core.

What's working: 

* earlyprintk and the usual platform stuff
* interrupts (PL192 VIC)
* cpuidle
* OHCI/EHCI (ehci-platform and ohci-platform)
* PrimeCell PL061 GPIO lines
* PrimeCell PL022 SPI
* 8250-compatible serial ports
* SP805 Watchdog
* SP804 Timer

This patchset (The dts part of it, due to a few constants) depends on ion-physmem 
driver that has already been submitted to LKML and is (still) pending review. 

See: https://lkml.org/lkml/2015/6/22/323
 
Links to product pages: 
http://www.module.ru/en/catalog/micro/micro_pc/
http://www.module.ru/en/catalog/micro/mikroshema_dekodera_cifrovogo_televizionnogo_signala_sbis_k1879hb1ya/

RC Module's github page: 
https://github.com/RC-MODULE/

Andrew Andrianov (4):
  ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
  of: Add vendor prefix for RC Module
  ARM: dts: rcm-k1879xb1: Add dts files for K1879XB1YA
  ARM: Add defconfig for RC Module K1879XB1YA SoC

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig                                   |   19 +
 arch/arm/Kconfig.debug                             |    5 +-
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts          |  158 ++
 arch/arm/boot/dts/rcm-k1879xb1.dtsi                |  521 ++++
 arch/arm/configs/rcm_k1879xb1ya_defconfig          | 2638 ++++++++++++++++++++
 arch/arm/mach-rcm-k1879xb1/Kconfig                 |    0
 arch/arm/mach-rcm-k1879xb1/Makefile                |    2 +
 arch/arm/mach-rcm-k1879xb1/Makefile.boot           |    4 +
 arch/arm/mach-rcm-k1879xb1/board-dt.c              |  152 ++
 arch/arm/mach-rcm-k1879xb1/cpuidle.c               |   48 +
 arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h |   75 +
 .../mach-rcm-k1879xb1/include/mach/uncompress.h    |   54 +
 15 files changed, 3678 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1.dtsi
 create mode 100644 arch/arm/configs/rcm_k1879xb1ya_defconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Kconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile.boot
 create mode 100644 arch/arm/mach-rcm-k1879xb1/board-dt.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/cpuidle.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/include/mach/hardware.h
 create mode 100644 arch/arm/mach-rcm-k1879xb1/include/mach/uncompress.h

-- 
2.1.4
