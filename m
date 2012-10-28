From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 28 Oct 2012 19:31:05 +0100
Subject: [PATCH v3 0/6] DT support for AT91RM9200
Message-ID: <1351449071-5763-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 is a fix for a build failure which can happen if board-dt is enabled when no AT91SAM machines are enabled.

Patch 2 adds DT support to the AT91RM9200 system timer. Based on AT91 PIT patch by Jean-Christophe PLAGNIOL-VILLARD.

Patch 3 adds clock lookups for DT.

Patch 4 adds a new board for RM9200 DT support.

Patch 5-6 adds the base devicetree for AT91RM9200 and support for AT91RM9200-EK board.


I don't have a AT91RM9200-EK to test on but I was able to boot at91rm9200ek.dts on my custom board using a initrd. As far as I can tell pinctrl, usart and ohci all work.

Patches based on linux-next.


Joachim Eastwood (6):
  ARM: AT91: Fix build failure on board-dt
  ARM: AT91: Add DT support to AT91RM9200 System Timer
  ARM: AT91: Add usart/tc/pio/ohci DT clock lookup to AT91RM9200
  ARM: AT91: Add AT91RM9200 DT board
  ARM: AT91: Add AT91RM9200 device tree
  ARM: AT91: Add AT91RM9200EK board device tree

 .../devicetree/bindings/arm/atmel-at91.txt         |   6 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91rm9200.dtsi                  | 333 +++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts                 |  78 +++++
 arch/arm/mach-at91/Kconfig                         |   9 +
 arch/arm/mach-at91/Makefile                        |   1 +
 arch/arm/mach-at91/at91rm9200.c                    |  18 ++
 arch/arm/mach-at91/at91rm9200_time.c               |  63 +++-
 arch/arm/mach-at91/board-rm9200-dt.c               |  59 ++++
 arch/arm/mach-at91/generic.h                       |   1 +
 arch/arm/mach-at91/setup.c                         |  14 +
 11 files changed, 582 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91rm9200.dtsi
 create mode 100644 arch/arm/boot/dts/at91rm9200ek.dts
 create mode 100644 arch/arm/mach-at91/board-rm9200-dt.c

-- 
1.8.0
