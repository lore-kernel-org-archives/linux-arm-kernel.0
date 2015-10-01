From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Oct 2015 14:38:49 +0200
Subject: [GIT PULL] at91: dt for 4.4 #1
Message-ID: <1443703129-32278-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Usual DT changes for AT91. The big thing is the addition of our new pinmux by
Ludovic that has led to these sama5d2 pinmux additions.
More content will come and particularly with more nodes added to sama5d2 and to
the sama5d2 Xplained board.

Thanks, best regards,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt

for you to fetch changes up to a9b672a636a599cc052afcb6837e3177dc53c143:

  ARM: at91/dt: sama5d2 Xplained: add device pin muxing (2015-09-23 16:26:47 +0200)

----------------------------------------------------------------
First batch of DT changes for 4.4:
- some DT fixes: dma declaration, led labels
- disable some nodes: PMIC on sama5d3 Xplained, unused i2c1 on at91sam9n12ek
- add some others that were missing: touchscreen, cryto nodes, LCD panels or
  image capture properties on various boards
- as the new pinmux for sama5d2 was accepted, we can now add the definitions
  and the actual muxing for sama5d2 Xplained board

----------------------------------------------------------------
Bo Shen (1):
      ARM: at91/dt: at91sam9n12ek: disable i2c1

Holger Busse (1):
      ARM: at91/dt: corrections to i2c1 declaration to sama5d4

Josh Wu (6):
      ARM: at91/dt: at91sam9n12ek: fix the led labels name
      ARM: at91/dt: at91sam9x5: enable iio touchscreen for 9x5ek
      ARM: at91/dt: sama5d3: update iio config for touchscreen
      ARM: at91/dt: sama5d4: add pioD pin mux mask and enable pioD
      ARM: at91/dt: sama5d4 xplained: enable the led D8
      ARM: at91/dt: ov2640: add hsync/vsync-active property

Ludovic Desroches (2):
      ARM: at91/dt: add sama5d2 pinmux
      ARM: at91/dt: sama5d2 Xplained: add device pin muxing

Nicolas Ferre (2):
      ARM: at91/dt: sama5d3 xplained: disable pmic
      ARM: at91/dt: sama5d4: enable crypto nodes

Patrice Vilchez (1):
      ARM: at91/dt: sama5d4ek: Add support of QT1070 and Maxtouch

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  61 ++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts |   2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |  27 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   2 +
 arch/arm/boot/dts/at91sam9n12ek.dts         |   8 +-
 arch/arm/boot/dts/at91sam9x5.dtsi           |   3 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   8 +
 arch/arm/boot/dts/sama5d2-pinfunc.h         | 880 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3.dtsi              |   3 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi           |   2 +
 arch/arm/boot/dts/sama5d4.dtsi              |  17 +-
 12 files changed, 996 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d2-pinfunc.h

-- 
Nicolas Ferre
