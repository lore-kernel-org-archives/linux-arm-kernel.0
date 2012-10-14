From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 14 Oct 2012 23:46:34 +0200
Subject: [PATCH 0/5] Add DT support for AT91RM9200
Message-ID: <1350251199-28065-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

This patch series add support for devicetree on AT91RM9200. Series is dependent upon at91-pinctrl.

There isn't support for any boards yet, but I am working on one now. I will submit it once I have a couple of more bindings in place.

Patch 1 is a fix for a build failure which can happen if board-dt is enabled when no AT91SAM machines are enabled.

regards
Joachim Eastwood


Joachim Eastwood (5):
  ARM: AT91: Fix build failure on board-dt
  ARM: AT91: Add DT support to AT91RM9200 System Timer
  ARM: AT91: Add usart/tc/pio DT clock lookup to AT91RM9200
  ARM: AT91: Add AT91RM9200 DT board
  ARM: AT91: Add AT91RM9200 device tree

 .../devicetree/bindings/arm/atmel-at91.txt         |   6 +
 arch/arm/boot/dts/at91rm9200.dtsi                  | 333 +++++++++++++++++++++
 arch/arm/mach-at91/Kconfig                         |   9 +
 arch/arm/mach-at91/Makefile                        |   1 +
 arch/arm/mach-at91/at91rm9200.c                    |  17 ++
 arch/arm/mach-at91/at91rm9200_time.c               |  63 +++-
 arch/arm/mach-at91/board-rm9200-dt.c               |  59 ++++
 arch/arm/mach-at91/generic.h                       |   1 +
 arch/arm/mach-at91/setup.c                         |  14 +
 9 files changed, 501 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91rm9200.dtsi
 create mode 100644 arch/arm/mach-at91/board-rm9200-dt.c

-- 
1.7.12.3
