From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:47:59 +0200
Subject: [RFC v4 0/7] extcon: usb-gpio: fixes and improvements
Message-ID: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Some time ago, Robert tried to add VBUS detection to extcon-usb-gpio
driver [1].  There was a discussion about patch #2 ("extcon: usb-gpio:
add support for VBUS detection").

The final conclusion was that Chanwoo will add VBUS/ID notifiers [2].
That unfortunately never happened so this patchset is a follow up.

1. Add VBUS/ID cable state notifiers to extcon, so USB controllers
   could use it.
2. Add VBUS detection to extcon-usb-gpio driver.

Some parts are based on old Robert's work, some are new, some are
reworked.


Best regards,
Krzysztof


[1] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1923193
[2] http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1941152


Krzysztof Kozlowski (5):
  Revert "extcon: usb-gpio: switch to use pm wakeirq apis"
  extcon: Add raw VBUS and ID cable states
  extcon: usb-gpio: Add support for VBUS detection
  ARM: exynos_defconfig: Enable EXTCON_USB_GPIO for Odroid XU3 USB OTG
  ARM: dts: exynos: Add extcon-usb-gpio node for Odroid XU3

Robert Baldyga (2):
  Documentation: extcon: usb-gpio: update usb-gpio binding description
  extcon: usb-gpio: make debounce value configurable in devicetree

 .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  28 ++++-
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  21 ++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  21 ++++
 arch/arm/configs/exynos_defconfig                  |   1 +
 drivers/extcon/extcon-usb-gpio.c                   | 138 +++++++++++++++++----
 drivers/extcon/extcon.c                            |   3 +
 include/linux/extcon.h                             |   8 +-
 7 files changed, 190 insertions(+), 30 deletions(-)

-- 
1.9.1
