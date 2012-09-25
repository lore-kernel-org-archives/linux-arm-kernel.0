From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue, 25 Sep 2012 12:25:02 +0200
Subject: [PATCH v4 0/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This set of patches is for adding device tree support to the
at91sam_wdt driver.

I've tested it on an at91sam9260 board (evk-pro3).

Changes:
v4:
 - use "atmel,at91sam9260-wdt" as compatible
v3:
 - add heartbeat option
 - default disabled for all the soc, enable only for evk-pro3 board
 - add at91sam9263 and at91sam9g45 soc
v2:
 - add missing to and cc addresses

Fabio Porcedda (2):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91: add at91sam9_wdt driver to at91sam926x, at91sam9g45

 .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                      |  4 ++++
 drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
 6 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3
