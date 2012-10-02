From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue,  2 Oct 2012 18:00:59 +0200
Subject: [PATCH v7 0/3] watchdog: at91sam9_wdt: add device tree support
Message-ID: <1349193662-23482-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patchset is for adding device tree support to the
at91sam9_wdt driver.

Another patchset will follow to add the new "timeout" binding to the
watchdog framework, at91sam9_wdt driver and to all the relevant drivers.

Changes:
v7:
 - split the patchset
 - remove timeout binding
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

Fabio Porcedda (3):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
  ARM: at91/dts: evk-pro3: enable watchdog

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                       |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                           |  4 ++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 6 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3
