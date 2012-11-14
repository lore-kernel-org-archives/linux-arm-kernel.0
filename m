From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 14 Nov 2012 15:15:58 +0800
Subject: [PATCH 00/11] watchdog/at91sam9_wdt: use watchdog framework,
 support DT
Message-ID: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All

The patch series is intended to convert to use the watchdog framework,
and add support to device tree.
It has been tested on sam9m10g45ek, sam9g20ek, sam9263ek and sam9g25ek.

It is based on v3.7-rc5.

Best Regards
Wenyou Yang

Wenyou Yang (11):
  watchdog/at91sam9_wdt: remove the file_operations struct
  watchdog/at91sam9_wdt: change the at91wdt_private struct to the
    at91wdt_drvdata struct
  watchdog/at91sam9_wdt: change the wdt_read and wdt_write macro to the
    inline function
  watchdog/at91sam9_wdt: change "at91_wdt_settimeout" function name to
    "at91wdt_enable"
  watchdog/at91sam9_wdt: add to use the watchdog framework
  watchdog/at91sam9_wdt: change the timer function name
  watchdog/at91sam9_wdt: add nowayout helpers to Watchdog Timer Driver
    Kernel API
  watchdog/at91sam9_wdt: use module_platform_driver()
  watchdog/at91sam9_wdt: add support to device tree
  watchdog/at91sam9_wdt: using dev_info replaces pr_info, dev_crit
    repalces pr_crit
  ARM: dts: add the watchdog nodes for atmel SoC

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   14 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |    6 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    6 +
 arch/arm/boot/dts/at91sam9263ek.dts                |    4 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    4 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |    4 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    4 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    6 +
 arch/arm/boot/dts/at91sam9n12ek.dts                |    4 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    6 +
 drivers/watchdog/Kconfig                           |    1 +
 drivers/watchdog/at91sam9_wdt.c                    |  294 ++++++++------------
 13 files changed, 185 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.9.5
