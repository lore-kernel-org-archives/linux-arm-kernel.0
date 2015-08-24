From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 11:18:09 +0900
Subject: [PATCH 0/3] ARM: uniphier: add outer cache support and rework SMP
 operations
Message-ID: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1/3: add outer cache support
2/3: rework SMP operations
3/3: add device tree nodes

Because 2/3 highly depends on 1/3, I hope whole of this series
is applied to ARM-SOC tree.

Olof,
>From this series, I am using "ARM: uniphier:" rather than "ARM: UniPhier:"
for the subject prefixes because I noticed you often rephased so when you
applied my patches.
Are sub-arch names in lower cases preferable in subject prefixes?



Masahiro Yamada (3):
  ARM: uniphier: add outer cache support
  ARM: uniphier: rework SMP operations to use trampoline code
  ARM: dts: uniphier: add outer cache controller nodes

 .../bindings/arm/uniphier/cache-uniphier.txt       |  30 ++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi            |   7 +
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi           |   7 +
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi           |  14 +
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi           |   7 +
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi           |   7 +
 arch/arm/boot/dts/uniphier-proxstream2.dtsi        |   7 +
 arch/arm/include/asm/hardware/cache-uniphier.h     |  40 ++
 arch/arm/mach-uniphier/Makefile                    |   2 +-
 arch/arm/mach-uniphier/headsmp.S                   |  43 ++
 arch/arm/mach-uniphier/platsmp.c                   | 183 ++++++--
 arch/arm/mach-uniphier/uniphier.c                  |  11 +
 arch/arm/mm/Kconfig                                |  10 +
 arch/arm/mm/Makefile                               |   1 +
 arch/arm/mm/cache-uniphier.c                       | 518 +++++++++++++++++++++
 16 files changed, 857 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
 create mode 100644 arch/arm/include/asm/hardware/cache-uniphier.h
 create mode 100644 arch/arm/mach-uniphier/headsmp.S
 create mode 100644 arch/arm/mm/cache-uniphier.c

-- 
1.9.1
