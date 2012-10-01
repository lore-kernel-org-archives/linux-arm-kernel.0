From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Mon,  1 Oct 2012 14:24:36 +0200
Subject: [PATCH v6 0/5] watchdog: orion_wdt & at91sam9_wdt: improve dt support
Message-ID: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This set of patches is for adding device tree support to the
at91sam9_wdt driver and to add the new timeout property to
the watchdog core.

I've tested the at91sam9_wdt modifications on an at91sam9260 board (evk-pro3).

Changes:
v6:
 - add watchdog core proprty timeout binding
 - add as example to the orion_wdt driver the new timeout binding
v5:
 - split dts commit in two, one for socs and one for boards.
v4:
 - use "atmel,at91sam9260-wdt" as compatible
v3:
 - add heartbeat option
 - default disabled for all the soc, enable only for evk-pro3 board
 - add at91sam9263 and at91sam9g45 soc
v2:
 - add missing to and cc addresses



Fabio Porcedda (5):
  watchdog: core: dt: add support for the timeout device tree property
  watchdog: orion_wdt: dt: add the timeout property binding
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
  ARM: at91/dts: evk-pro3: enable watchdog

 .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
 .../devicetree/bindings/watchdog/marvel.txt         |  5 +++++
 Documentation/watchdog/watchdog-kernel-api.txt      |  3 +++
 arch/arm/boot/dts/at91sam9260.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                      |  4 ++++
 drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
 drivers/watchdog/orion_wdt.c                        |  2 +-
 include/linux/watchdog.h                            | 11 +++++++++++
 10 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3
