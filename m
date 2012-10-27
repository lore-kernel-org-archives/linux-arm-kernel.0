From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 15:21:34 +0530
Subject: [PATCH V2 0/5] Pinctrl: SPEAr: Add support for plgpio driver
Message-ID: <cover.1351330569.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset has an interesting history. It was first started by me. After i
left ST Shiraz took over and now i am back again :)

The idea of this series is to add plgpio support for SPEAr. PLGPIO's are pads
which can be configured as GPIO and so it is closely bound to pinctrl framework.

Some of these are sent earlier and Acked-by you. So, they will retain that. The
main bottleneck is still: 
  gpiolib: provide provision for gpiolib to register pin range

I have tried to fix most of your comments. Please see if they are fixed.

This is rebased over:

http://www.spinics.net/lists/arm-kernel/msg203465.html

--
viresh

Shiraz Hashim (1):
  gpiolib: provide provision for gpiolib to register pin range

Viresh Kumar (4):
  Revert "pinctrl: remove pinctrl_remove_gpio_range"
  pinctrl: SPEAr: Add plgpio driver
  pinctrl: SPEAr: Add gpio ranges support
  ARM: SPEAr: Add plgpio node in device tree dtsi files

 Documentation/devicetree/bindings/gpio/gpio.txt |  36 ++
 Documentation/gpio.txt                          |  26 +
 Documentation/pinctrl.txt                       |   3 +
 arch/arm/boot/dts/spear1310-evb.dts             |   4 +
 arch/arm/boot/dts/spear1310.dtsi                |  27 +
 arch/arm/boot/dts/spear1340-evb.dts             |   4 +
 arch/arm/boot/dts/spear1340.dtsi                |  26 +
 arch/arm/boot/dts/spear310.dtsi                 |  22 +-
 arch/arm/boot/dts/spear320-evb.dts              |   4 +
 arch/arm/boot/dts/spear320.dtsi                 |  23 +-
 drivers/gpio/gpiolib-of.c                       |  56 ++
 drivers/gpio/gpiolib.c                          |  43 ++
 drivers/pinctrl/core.c                          |  27 +
 drivers/pinctrl/devicetree.c                    |  13 +
 drivers/pinctrl/spear/Kconfig                   |  11 +
 drivers/pinctrl/spear/Makefile                  |   1 +
 drivers/pinctrl/spear/pinctrl-plgpio.c          | 746 ++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear.c           | 107 +++-
 drivers/pinctrl/spear/pinctrl-spear.h           |  46 ++
 drivers/pinctrl/spear/pinctrl-spear1310.c       | 264 +++++++++
 drivers/pinctrl/spear/pinctrl-spear300.c        |   2 +
 drivers/pinctrl/spear/pinctrl-spear310.c        |   2 +
 drivers/pinctrl/spear/pinctrl-spear320.c        |   2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c        |  37 ++
 include/asm-generic/gpio.h                      |  25 +
 include/linux/gpio.h                            |   3 +
 include/linux/pinctrl/pinctrl.h                 |  19 +
 27 files changed, 1560 insertions(+), 19 deletions(-)
 create mode 100644 drivers/pinctrl/spear/pinctrl-plgpio.c

-- 
1.7.12.rc2.18.g61b472e
