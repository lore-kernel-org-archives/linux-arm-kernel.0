From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Oct 2016 11:41:29 +0200
Subject: [PATCH v2 0/6] ARM: at91: initial samx7 support
Message-ID: <20161020094135.18221-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds initial support for Atmel armv7m SoCs.

Changes in v2:
 - fixed checkpatch issues
 - Added documentation
 - removed Ethernet from the dtsi until the driver change is taken


Alexandre Belloni (3):
  ARM: at91: Documentation: add samx7 families
  ARM: at91: Document samx7 compatibles
  ARM: at91: handle CONFIG_PM for armv7m configurations

Szemz? Andr?s (3):
  ARM: at91: Add armv7m support
  ARM: dts: at91: add samx7 dtsi
  ARM: at91: debug: add samx7 support

 Documentation/arm/Atmel/README                     |   44 +-
 .../devicetree/bindings/arm/atmel-at91.txt         |   30 +
 arch/arm/Kconfig.debug                             |   10 +
 arch/arm/boot/dts/samx7.dtsi                       | 1128 ++++++++++++++++++++
 arch/arm/mach-at91/Kconfig                         |   15 +-
 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/Makefile.boot                   |    3 +
 arch/arm/mach-at91/samx7.c                         |   71 ++
 arch/arm/mach-at91/soc.h                           |   21 +
 9 files changed, 1320 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/samx7.dtsi
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samx7.c

-- 
2.9.3
