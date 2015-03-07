From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sat, 7 Mar 2015 17:12:01 +0100
Subject: [GIT PULL] at91: dt for 4.1 #1
Message-ID: <1425744721-27138-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a first batch of DT updates for 4.1. You'll find many little nodes
added to several chips and boards. The bulk of it is related to sama5d4 though.
Sama5d4 Xplained board is also added during this cycle.

Please note that this tag is stacked on top of my first at91-fixes pull-request
that you already took. This is due to a conflict that shows up in the aliases
section of sama5d4.dtsi.
I did this to avoid having to deal with this conflict for the whole cycle. If
you want me to do someting else, please tell me.

Thanks, best regards,

The following changes since commit e61b8370d7e4ef40194bc62d6e22f3c95f4a01ec:

  Merge tag 'at91-fixes' into at91-4.1-dt (2015-03-04 15:17:23 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt

for you to fetch changes up to 35762a624f82dbea7c62177bf3ef0cde0d0f84bc:

  ARM: at91/dt: sama5d4: add ISI dt support (2015-03-04 18:36:17 +0100)

----------------------------------------------------------------
First batch of DT changes for 4.1:
- at91sam9x5 & EK board: ISI and camera sensors
- at91sam9n12 & EK board: USB gadget nodes
- sama5d3: typos, gpio-keys on Xplained board
- sama5d4: i2c, leds, audio, ISI, crypto, pwm missing nodes
- new sama5d4 xplained board

----------------------------------------------------------------
Bo Shen (7):
      ARM: at91/dt: at91sam9n12: add udp device node
      ARM: at91/dt: at91sam9n12ek: enable udp
      ARM: at91: dt: sama5d4: add ssc nodes
      ARM: at91: dt: sama5d4ek: enable ssc0
      ARM: at91: dt: sama5d4ek: add and enable wm8904
      ARM: at91: dt: sama5d4ek: enable audio
      ARM: at91/dt: sama5d4: add pwm0 device node

Josh Wu (7):
      ARM: at91: at91sam9x5/dts: add ISI dt support, include isi node, pinctrls
      ARM: at91: at91sam9x5ek/dts: add ov2640 support
      ARM: at91: at91sam9g25ek/dts: enable ISI and ov2640
      ARM: at91/dt: sama5d4ek: add leds in DT node
      ARM: at91/dt: sama5d4: add #{address, size}_cells properties for macb0
      ARM: at91/dt: sama5d4: add dts for sama5d4 xplained board
      ARM: at91/dt: sama5d4: add ISI dt support

Leilei Zhao (1):
      ARM: at91/dt: sama5d4: add aes, sha and tdes nodes

Nicolas Ferre (3):
      ARM: at91/dt/trivial: correct file headers for SAMA5D3 SoC peripherals
      ARM: at91/dt: gpio-keys: address-cells and size-cells properties are not needed
      ARM: at91/dt: sama5d4 xplained: add i2c0

Philip Attfield (1):
      ARM: at91/dt: add i2c1 declaration to sama5d4

Wenyou Yang (1):
      ARM: at91/dt: at91-sama5d3_xplained: add gpio-key pinctrl property

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   8 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 241 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  55 ++++++-
 arch/arm/boot/dts/at91sam9g25.dtsi          |   1 +
 arch/arm/boot/dts/at91sam9g25ek.dts         |  18 +++
 arch/arm/boot/dts/at91sam9n12.dtsi          |   9 ++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  14 ++
 arch/arm/boot/dts/at91sam9x5_isi.dtsi       |  46 ++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |  48 ++++++
 arch/arm/boot/dts/sama5d35ek.dts            |   2 -
 arch/arm/boot/dts/sama5d3_can.dtsi          |   2 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi         |   2 +-
 arch/arm/boot/dts/sama5d3_gmac.dtsi         |   2 +-
 arch/arm/boot/dts/sama5d3_lcd.dtsi          |   2 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi         |   2 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi         |   2 +-
 arch/arm/boot/dts/sama5d3_uart.dtsi         |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi              | 192 ++++++++++++++++++++++
 19 files changed, 638 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_xplained.dts

-- 
Nicolas Ferre
