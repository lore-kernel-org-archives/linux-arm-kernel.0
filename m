From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  1 Jun 2017 22:05:55 +0200
Subject: [PATCH v4 0/6] ARM: at91: initial samx7 support
Message-ID: <20170601200601.11035-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for Atmel armv7m SoCs.

Changes in v4:
 - rename the family samv7 as the internal name is samv7x and it may conflict
   with future SoCs.

Changes in v3:
 - dropped most of the changes in Atmel/README
 - rebased on v4.12-rc1
 - removed the dtsi until the tcb series is taken

Changes in v2:
 - fixed checkpatch issues
 - Added documentation
 - removed Ethernet from the dtsi until the driver change is taken


Alexandre Belloni (3):
  ARM: at91: Documentation: add armv7m families
  ARM: at91: Document armv7m compatibles
  ARM: at91: handle CONFIG_PM for armv7m configurations

Szemz? Andr?s (3):
  ARM: at91: Add armv7m support
  ARM: at91: add armv7m SoC detection
  ARM: at91: debug: add samv7x support

 Documentation/arm/Atmel/README                     | 38 +++++++++++++++++++++-
 .../devicetree/bindings/arm/atmel-at91.txt         | 30 +++++++++++++++++
 arch/arm/Kconfig.debug                             | 10 ++++++
 arch/arm/mach-at91/Kconfig                         | 16 ++++++++-
 arch/arm/mach-at91/Makefile                        |  4 +--
 arch/arm/mach-at91/Makefile.boot                   |  3 ++
 arch/arm/mach-at91/samv7.c                         | 34 +++++++++++++++++++
 drivers/soc/atmel/soc.c                            | 24 ++++++++++++++
 drivers/soc/atmel/soc.h                            | 26 +++++++++++++++
 9 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samv7.c

-- 
2.11.0
