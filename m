From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Aug 2017 13:10:38 +0200
Subject: [PATCH v3 0/3] arm64: Realtek RTD1295 RTC
Message-ID: <20170828111041.17946-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds the RTC for the Realtek RTD1295 SoC.
Based on my RTD1295 clk series.

There being no public source code for RTD1295, the implementation is based on
register offsets seen in the vendor DT, as well as older mach-rtk119x code
published by QNAP.

v3 drops a redundant spinlock and refactors a helper.

The DT node depends on the clk series for clock index and header.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v2 -> v3:
* Dropped spinlock (Andrew)
* Improved year_days vs. days_in_year readability

v1 -> v2:
* Updated rtc driver to no longer use open/release (Alexandre)
* Cleaned up debug output (Andrew)
* Avoided COMPILE_TEST division errors (kbuild)
* Various cleanups and extensions

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc at vger.kernel.org
Cc: Roc He <hepeng@zidoo.tv>
Cc: ??? <jiang.liqin@geniatech.com>
Cc: devicetree at vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>

Andreas F?rber (3):
  dt-bindings: rtc: Add Realtek RTD1295
  rtc: Add Realtek RTD1295
  arm64: dts: realtek: Add RTD1295 RTC node

 .../devicetree/bindings/rtc/realtek,rtd119x.txt    |  16 ++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   6 +
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-rtd119x.c                          | 241 +++++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
 create mode 100644 drivers/rtc/rtc-rtd119x.c

-- 
2.12.3
