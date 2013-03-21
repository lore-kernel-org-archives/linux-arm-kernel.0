From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 21 Mar 2013 16:26:58 +0100
Subject: [GIT PULL] at91: dt for 3.10 #1
Message-ID: <514B26C2.5020804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is an AT91 pull-request about Device Tree material for -next.


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to 6901d947be5ba1245a0f63271355b95f9056a362:

  ARM: at91/at91sam9x5cm: add 1-wire chip on CM board (2013-03-21 16:07:15 +0100)

----------------------------------------------------------------
DT modifications for at91rm9200 and at91sam9x5 SoCs, mainly around
I2C. Also some cleanup of some unneeded properties and conflicting
nodes.
One more DT-only board based on at91rm9200.

----------------------------------------------------------------
Joachim Eastwood (3):
      ARM: at91: add TWI bindings to RM9200 DT
      ARM: at91: add pinctrl nodes to i2c-gpio on RM92000 DT
      ARM: at91: add MPA 1600 DT board

Nicolas Ferre (1):
      ARM: at91/dt: gpio-keys: remove address-cells and size-cells properties

Richard Genoud (4):
      ARM: at91: dt: at91sam9x5: add i2c pinctrl
      ARM: at91: dt: at91sam9x5: add i2c-gpio pinctrl
      ARM: at91/at91sam9x5ek: i2c1 and i2c2 conflict with macb and lcd
      ARM: at91/at91sam9x5cm: add 1-wire chip on CM board

 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/at91rm9200.dtsi           | 28 ++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         |  2 -
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  2 -
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  2 -
 arch/arm/boot/dts/at91sam9n12ek.dts         |  2 -
 arch/arm/boot/dts/at91sam9x5.dtsi           | 60 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5cm.dtsi         | 20 ++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  8 ----
 arch/arm/boot/dts/mpa1600.dts               | 69 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91rm9200.c             |  1 +
 11 files changed, 179 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/mpa1600.dts

Thanks, best regards,
-- 
Nicolas Ferre
