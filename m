From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 May 2012 16:45:36 +0530
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
Message-ID: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,Olof,

This have few more dependencies:
- ARM: 7376/1: clkdev: Implement managed clk_get()
- pinctrl branch from Linus

The following changes since commit 880702fb50ec63a832aaeafcb251295f3c6ce722:

  SPEAr: Update defconfigs (2012-05-09 14:53:53 +0530)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-pinctrl-update

for you to fetch changes up to a8f048037fb467b39ac1aeb15361a2c8366d8a2d:

  SPEAr: Add plgpio node in device tree dtsi files (2012-05-09 14:55:55 +0530)

----------------------------------------------------------------
Viresh Kumar (6):
      gpiolib: Add of_get_gpio_chip_by_phandle() helper
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
 drivers/of/gpio.c                         |   32 ++
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
 include/linux/of_gpio.h                   |    9 +-
 21 files changed, 1228 insertions(+), 14 deletions(-)
 create mode 100644 drivers/pinctrl/spear/pinctrl-plgpio.c
