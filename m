From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 25 Feb 2017 02:47:17 +0800
Subject: [PATCH v4 0/4] leds: add leds-mt6323 support on MT7623 SoC
Message-ID: <1487962041-6548-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MT7623 SoC uses MT6323 PMIC as the default power supply
which has LED function insides. The patchset introduces
the LED support for MT6323 with on, off and hardware
dimmed and blinked and it should work on other similar
SoCs if also using MT6323.

Changes since v1:
- fixed typo in the comments
- sorted include directives alphabetically
- applied all register definitions with MT6323 prefix
- removed the redundant structure declaration
- fixed coding style defined in kernel doc format consistently
- added error handling into all the occurrences where regmap APIs
  are used
- removed loudly debug message
- made magic constant into meaningful macro
- added missing mutex_destroy when module removed called
- updated module license with GPL
- fixed sparse warnings

Changes since v2:
- fixed the typo in devicetree Documentation
- cleaned up the style and explanation in the comments
- applied all macro/struct/function definitions with MT6323 prefix
- put the logic about the setup from device tree into function for simplicity

Changes since v3:
- changed the variable current_brightness into the proper type
- removed the redundant member led_num from mt6323_leds structure
- collected the brightness setting into mt6323_led_hw_brightness() call
- added brightness_get() support into the core layer
- fixed zero-duty cycle handling due to hardware doesn't support
- fixed duty-cycle calculation mapping to the hardware register
- added brightness as the input in mt6323_led_hw_on() call
- enhanced the error handling in mt6323_led_set_dt_default() call
- fixed potential issue which caused accessing unallocated memory if excessive
  the led controller nodes are defined
- fixed redundant memory allocation in mt6323_leds structure.
- added reg property for defining the led controller for which the child
  node is predestined.

Sean Wang (4):
  Documentation: devicetree: Add document bindings for leds-mt6323
  Documentation: devicetree: Add LED subnode binding for MT6323 PMIC
  leds: Add LED support for MT6323 PMIC
  mfd: mt6397: Add MT6323 LED support into MT6397 driver

 .../devicetree/bindings/leds/leds-mt6323.txt       |  64 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +
 drivers/leds/Kconfig                               |   8 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-mt6323.c                         | 500 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   4 +
 6 files changed, 581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 drivers/leds/leds-mt6323.c

-- 
1.9.1
