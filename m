From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed,  9 Apr 2014 21:45:32 +0200
Subject: [PATCH 0/4] arm: Add basic support for Mediatek Cortex-A7 SoCs
Message-ID: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds basic support for the Mediatek Cortex-A7 SoCs.
Support is quite basic, as the only components working up to now are the
timers and the low-level debug via UART.

The patch series is build against torvalds/master tree


Matthias Brugger (4):
  clocksource: Add support for the Mediatek SoCs
  dt-bindings: add mtk-timer bindings
  arm: add basic support for Mediatek MT6589 boards
  arm: mediatek: Add earlyprintk support for MT6589

 .../bindings/timer/mediatek,mtk-timer.txt          |   19 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |   49 +++-
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/mtk6589.dtsi                     |  105 +++++++++
 arch/arm/include/debug/mediatek.S                  |   38 +++
 arch/arm/mach-mediatek/Kconfig                     |   14 ++
 arch/arm/mach-mediatek/Makefile                    |    1 +
 arch/arm/mach-mediatek/mediatek.c                  |   40 ++++
 drivers/clocksource/Kconfig                        |    4 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/mtk_timer.c                    |  248 ++++++++++++++++++++
 13 files changed, 521 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 arch/arm/boot/dts/mtk6589.dtsi
 create mode 100644 arch/arm/include/debug/mediatek.S
 create mode 100644 arch/arm/mach-mediatek/Kconfig
 create mode 100644 arch/arm/mach-mediatek/Makefile
 create mode 100644 arch/arm/mach-mediatek/mediatek.c
 create mode 100644 drivers/clocksource/mtk_timer.c

-- 
1.7.9.5
