From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:21 +0200
Subject: [PATCH 0/9] ARM: at91: dt and defconfig updates
Message-ID: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set adds display support for the at91sam9x5-ek and at91sam9n12ek.

To finally get the display working one would also need the following patches:
[PATCH 0/3] drm: atmel-hlcdc: add support for several SoCs
[PATCH] mfd: atmel-hlcdc: Add support for new SoCs
[PATCH] ARM: at91: pwm: atmel-hlcdc: add at91sam9n12 entry for the errata
[PATCH] drm: panel: simple: add QiaoDian qd43003c0-40

However, there is no real dependency and the bindings are quite common.

It also adds touchscreen and QT1070 support on at91sam9x5-ek.

The defconfig changes are adding the hlcdc support to at91_dt_defconfig and
there is one cleanup of a removed config option.

Alexandre Belloni (2):
  ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER
  ARM: at91/dt: at91sam9x5dm: add support for the touschscreen

Bo Shen (1):
  ARM: at91/dt: add drm support for at91sam9n12ek

Boris BREZILLON (4):
  ARM: at91/dt: define hlcdc node in at91sam9x5_lcd.dtsi
  ARM: at91/dt: include lcd dtsi in at91sam9x5 dtsis
  ARM: at91/dt: add at91sam9x5-ek Display Module dtsi
  ARM: at91/dt: enable lcd support for at91sam9x5 SoCs

Josh Wu (1):
  ARM: at91/defconfig: at91_dt: enable DRM hlcdc support

Nicolas Ferre (1):
  ARM: at91/dt: at91sam9x5dm: add QT1070 touch button controller

 arch/arm/boot/dts/at91sam9g15.dtsi    |   1 +
 arch/arm/boot/dts/at91sam9g15ek.dts   |  25 ++++++
 arch/arm/boot/dts/at91sam9g35.dtsi    |   1 +
 arch/arm/boot/dts/at91sam9g35ek.dts   |  21 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi    |  71 +++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts   |  61 +++++++++++++++
 arch/arm/boot/dts/at91sam9x35.dtsi    |   1 +
 arch/arm/boot/dts/at91sam9x35ek.dts   |  20 +++++
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi | 139 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5dm.dtsi   | 101 ++++++++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig    |   7 +-
 11 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91sam9x5dm.dtsi

-- 
2.1.4
