From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:42:02 +0530
Subject: [PATCH V2 0/5] pinctrl: SPEAr Updates
Message-ID: <cover.1336039716.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset mainly focuses on providing support to configure SPEAr pads as
gpios. For this i have added a gpiolib based driver and few changes in other
SPEAr pinctrl drivers.

It also contains minor fixes.

V1->V2:
- Passing gpio node via DT. Patch for this support in gpiolib is
  gpiolib: Add of_get_gpio_chip_by_phandle() helper
- Other minor fixes

Viresh Kumar (5):
  pinctrl: SPEAr: Don't set all non muxreg bits on pinctrl_disable
  pinctrl: SPEAr1310: Fix pin numbers for clcd_high_res
  pinctrl: SPEAr: Add plgpio driver
  pinctrl: SPEAr: Add gpio ranges support
  SPEAr: Add plgpio node in device tree dtsi files

 arch/arm/boot/dts/spear1310-evb.dts       |    4 +
 arch/arm/boot/dts/spear1310.dtsi          |   22 +
 arch/arm/boot/dts/spear1340-evb.dts       |    4 +
 arch/arm/boot/dts/spear1340.dtsi          |   21 +
 arch/arm/boot/dts/spear310-evb.dts        |    4 +
 arch/arm/boot/dts/spear310.dtsi           |   15 +
 arch/arm/boot/dts/spear320-evb.dts        |    4 +
 arch/arm/boot/dts/spear320.dtsi           |   16 +
 drivers/pinctrl/spear/Kconfig             |   11 +
 drivers/pinctrl/spear/Makefile            |    1 +
 drivers/pinctrl/spear/pinctrl-plgpio.c    |  738 ++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear.c     |  110 ++++-
 drivers/pinctrl/spear/pinctrl-spear.h     |   15 +
 drivers/pinctrl/spear/pinctrl-spear1310.c |  812 ++++++++++++++++++++++++++++-
 drivers/pinctrl/spear/pinctrl-spear1340.c |    8 +
 drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c  |  120 +++++
 19 files changed, 1898 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pinctrl/spear/pinctrl-plgpio.c

-- 
1.7.9
