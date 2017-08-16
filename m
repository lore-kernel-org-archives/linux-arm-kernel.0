From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:42 +0200
Subject: [PATCH 0/5] arm64: Realtek RTD1295 reset controllers
Message-ID: <20170816003847.6208-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds reset controllers for the Realtek RTD1295 SoC.

Since there is still no public source code for RTD1295, the individual resets
were derived from reset-names in the vendor DT; the implementation was a guess.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: Roc He <hepeng@zidoo.tv>
Cc: ??? <jiang.liqin@geniatech.com>
Cc: devicetree at vger.kernel.org

Andreas F?rber (5):
  dt-bindings: reset: Add Realtek RTD1295
  arm64: dts: realtek: Add RTD1295 reset controller nodes
  reset: Add Realtek RTD1295 driver
  arm64: dts: realtek: Add RTD1295 UART resets
  arm64: dts: realtek: Adopt RTD1295 reset constants

 .../bindings/reset/realtek,rtd129x-reset.txt       |  18 ++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  34 +++++++
 drivers/reset/Kconfig                              |   6 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-rtd129x.c                      | 100 ++++++++++++++++++
 include/dt-bindings/reset/realtek,rtd1295.h        | 112 +++++++++++++++++++++
 6 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/realtek,rtd129x-reset.txt
 create mode 100644 drivers/reset/reset-rtd129x.c
 create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

-- 
2.12.3
