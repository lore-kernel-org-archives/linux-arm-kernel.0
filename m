From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  8 Feb 2013 02:25:53 +0100
Subject: [PATCH 0/3] RM9200 DT i2c bindings and MPA 1600 support
Message-ID: <1360286756-29705-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

1st patch adds bindings for hardware i2c on RM9200. This also includes
pinctrl setup.

2nd patch adds pinctrl nodes to i2c-gpio which is need since the gpio
pins must be set to open drain. I suspect that this should be done in
other AT91 dtsi files as well, unless we want to rely on the
bootloader doing it.

3rd patch adds a new RM9200 DT board. This is minimal DT file with a 
lot of stuff missing. The plan is to add the ASoC stuff next.

Joachim Eastwood (3):
  ARM: at91: add TWI bindings to RM9200 DT
  ARM: at91: add pinctrl nodes to i2c-gpio on RM92000 DT
  ARM: at91: add MPA 1600 DT board

 arch/arm/boot/dts/Makefile        |  1 +
 arch/arm/boot/dts/at91rm9200.dtsi | 28 +++++++++++++++
 arch/arm/boot/dts/mpa1600.dts     | 71 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91rm9200.c   |  1 +
 4 files changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/mpa1600.dts

-- 
1.8.0
