From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Aug 2015 17:45:44 +0200
Subject: [GIT PULL] at91: dt for 4.3 #2
Message-ID: <20150807154544.GA18934@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Arnd, Olof, Kevin,

This is the second batch of DT changes for 4.3.
It is mainly some preparation to support properly getting the slow clock
from each driver so that the dtsis are ready when the driver change
lands in each subsystem.

It also adds support for the lcd controller on at91sam9x5 and
at91sam9n12. The driver changes have been submitted but didn't yet land
in the drm and mfd subsystem however, I don't expect any issue getting
those in.

Thanks, best regards,

The following changes since commit 22b5a0f7bc07ac4b4e4aab9a7f8cf2521819c1c4:

  ARM: at91/dt: add minimal sama5d2 Xplained board (2015-07-30 18:44:44 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-dt2

for you to fetch changes up to 761c5867ef031fae244d030bc17c93f5a3df106f:

  ARM: at91/dt: sama5d2: use slow clock where necessary (2015-08-07 17:33:54 +0200)

----------------------------------------------------------------
Second batch of DT changes for 4.3:
- Add the slow clock to the nodes that will use it
- Add hlcd to the at91sam9x5 and at91sam9n12
- Add touchscreen and touch button support to the at91sam9x5ek

----------------------------------------------------------------
Alexandre Belloni (15):
      Documentation: dt: atmel-at91: add clocks to system timer, rstc and shdwc
      Documentation: watchdog: at91sam9_wdt: add clocks property
      Documentation: dt: rtc: at91rm9200: add clocks property
      ARM: at91/dt: at91rm9200: use slow clock where necessary
      ARM: at91/dt: at91sam9260: use slow clock where necessary
      ARM: at91/dt: at91sam9261: use slow clock where necessary
      ARM: at91/dt: at91sam9263: use slow clock where necessary
      ARM: at91/dt: at91sam9g45: use slow clock where necessary
      ARM: at91/dt: at91sam9n12: use slow clock where necessary
      ARM: at91/dt: at91sam9rl: use slow clock where necessary
      ARM: at91/dt: at91sam9x5: use slow clock where necessary
      ARM: at91/dt: sama5d3: use slow clock where necessary
      ARM: at91/dt: sama5d4: use slow clock where necessary
      ARM: at91/dt: at91sam9x5dm: add support for the touschscreen
      ARM: at91/dt: sama5d2: use slow clock where necessary

Bo Shen (1):
      ARM: at91/dt: add drm support for at91sam9n12ek

Boris Brezillon (5):
      Documentation: dt: atmel-at91: add slow clock to tcb
      ARM: at91/dt: define hlcdc node in at91sam9x5_lcd.dtsi
      ARM: at91/dt: include lcd dtsi in at91sam9x5 dtsis
      ARM: at91/dt: add at91sam9x5-ek Display Module dtsi
      ARM: at91/dt: enable lcd support for at91sam9x5 SoCs

Nicolas Ferre (1):
      ARM: at91/dt: at91sam9x5dm: add QT1070 touch button controller

 .../devicetree/bindings/arm/atmel-at91.txt         |  13 +-
 .../bindings/rtc/atmel,at91rm9200-rtc.txt          |   2 +
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   2 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |  10 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |  11 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   7 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   7 +-
 arch/arm/boot/dts/at91sam9g15.dtsi                 |   1 +
 arch/arm/boot/dts/at91sam9g15ek.dts                |  25 ++++
 arch/arm/boot/dts/at91sam9g35.dtsi                 |   1 +
 arch/arm/boot/dts/at91sam9g35ek.dts                |  21 ++++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  12 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  83 +++++++++++-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  61 +++++++++
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   8 +-
 arch/arm/boot/dts/at91sam9x35.dtsi                 |   1 +
 arch/arm/boot/dts/at91sam9x35ek.dts                |  20 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  12 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi              | 139 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5dm.dtsi                | 101 +++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                     |   9 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   8 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  12 +-
 24 files changed, 528 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9x5dm.dtsi

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
