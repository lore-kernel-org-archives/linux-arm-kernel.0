From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:10:24 +0530
Subject: [PATCH V3 0/5] pinctrl: SPEAr Updates
Message-ID: <cover.1336448307.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset mainly focuses on providing support to configure SPEAr pads as
gpios. For this i have added a gpiolib based driver and few changes in other
SPEAr pinctrl drivers.

It also contains minor fixes.

V2->V3:
- Created Macros for spear_gpio_pingroups as suggested by Linus and Arnd.
- Included Acked-by from Linus

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
 drivers/pinctrl/spear/pinctrl-plgpio.c    |  738 +++++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear.c     |  110 ++++-
 drivers/pinctrl/spear/pinctrl-spear.h     |   26 +
 drivers/pinctrl/spear/pinctrl-spear1310.c |  182 +++++++-
 drivers/pinctrl/spear/pinctrl-spear1340.c |    8 +
 drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c  |   29 ++
 19 files changed, 1188 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pinctrl/spear/pinctrl-plgpio.c

-- 
1.7.9
