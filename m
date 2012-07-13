From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Jul 2012 10:38:43 +0200
Subject: [GIT PULL] ux500 dt for -next
Message-ID: <4FFFDE93.6050702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2b667a2d8005e7c8362a77365cedbcd71fa5d6c1:

  ARM: ux500: Over-ride the DT device naming scheme for pinctrl (2012-07-06 21:42:10 +0200)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git for-arm-soc-next

for you to fetch changes up to da38487000de965bb94b8f4bca88eade4bb9a485:

  ARM: ux500: Remove PMU platform registration when booting with DT (2012-07-13 10:14:41 +0200)

----------------------------------------------------------------
Lee Jones (20):
      ARM: ux500: Enable Device Tree support mmci for Snowball
      ARM: ux500: Remove unused i2c platform_data initialisation code
      ARM: ux500: Provide auxdata to be used as name base clock search for nmk-i2c
      ARM: ux500: Kconfig: Compile in leds-gpio support for Snowball
      ARM: ux500: Enable the user LED on Snowball via Device Tree
      ARM: ux500: Add a ab8500-gpadc node to the db8500 Device Tree
      ARM: ux500: Add support for input/ponkey into the db8500's Device Tree
      ARM: ux500: Enable LED heartbeat functionality on Snowball
      ARM: ux500: Enable LED heartbeat functionality on Snowbal via DT
      ARM: ux500: Add db8500 Device Tree node for ab8500-sysctrl
      ARM: ux500: Add db8500 Device Tree node for misc/ab8500-pwm
      ARM: ux500: Add a ab8500-usb Device Tree node for db8500 based devices
      ARM: ux500: Apply ab8500-debug node do the db8500 DT structure
      ARM: ux500: Correctly reference IRQs supplied by the AB8500 from Device Tree
      ARM: ux500: Enable the AB8500 RTC for all DT:ed DB8500 based devices
      ARM: ux500: Move rtc-pl031 registration to Device Tree when enabled
      pinctrl: pinctrl-nomadik: Append sleepmode property with vendor specific prefixes
      ARM: ux500: Ensure vendor specific properties have the vendor's identifier
      ARM: ux500: Remove temporary snowball_of_platform_devs enablement structure
      ARM: ux500: Remove PMU platform registration when booting with DT

 .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 +-
 arch/arm/boot/dts/db8500.dtsi                      |   77 +++++++++++++++++---
 arch/arm/boot/dts/snowball.dts                     |   21 +++++-
 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/board-mop500-sdi.c             |    4 +-
 arch/arm/mach-ux500/board-mop500.c                 |   63 +++-------------
 arch/arm/mach-ux500/board-mop500.h                 |    3 +
 arch/arm/mach-ux500/cpu-db8500.c                   |    4 +-
 drivers/i2c/busses/i2c-nomadik.c                   |    3 +-
 drivers/pinctrl/pinctrl-nomadik.c                  |    2 +-
 10 files changed, 108 insertions(+), 72 deletions(-)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
