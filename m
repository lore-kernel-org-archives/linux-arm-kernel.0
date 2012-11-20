From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 20 Nov 2012 22:44:24 +0100
Subject: [PULL pinctrl-for 3.8] at91 update
Message-ID: <20121120214424.GP4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

	this pull go over the pinctrl at91 branch

	This contain pinctrl ond dt that depends on

The following changes since commit f6f94f6660dbe34039e5c86a46c7845589e7ee0c:

  pinctrl: at91: Staticize non-exported symbols (2012-11-05 14:30:45 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git delivery/pinctrl-at91-3.8

for you to fetch changes up to ad8a15d99cf2c8ab8ac1ab28402c49ec2548358d:

  ARM: at91: add Somfy Animeo IP board support (2012-11-19 07:51:11 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (7):
      pinctrl: at91: provide gpio names
      pinctrl: at91 add deglitch, debounce, pull down and schmitt trigger mux option support
      ARM: at91sam9: add macb pinctrl support
      ARM: at91: fix usart/uart namimg in pinctrl
      ARM: at91: dt: at91sam9260: split rts and cts pinctrl not
      ARM: at91: add Ronetix pm9g45 board support
      ARM: at91: add Somfy Animeo IP board support

Joachim Eastwood (6):
      ARM: AT91: Fix build failure on board-dt
      ARM: AT91: Add DT support to AT91RM9200 System Timer
      ARM: AT91: Add usart/tc/pio/ohci DT clock lookup to AT91RM9200
      ARM: AT91: Add AT91RM9200 DT board
      ARM: AT91: Add AT91RM9200 device tree
      ARM: AT91: Add AT91RM9200EK board device tree

 Documentation/devicetree/bindings/arm/atmel-at91.txt             |    6 +++
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt |    9 +++-
 arch/arm/boot/dts/Makefile                                       |    4 ++
 arch/arm/boot/dts/animeo_ip.dts                                  |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200.dtsi                                |  349 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91rm9200ek.dts                               |   79 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                               |  132 +++++++++++++++++++++++++++++++++++++++++-----------------
 arch/arm/boot/dts/at91sam9263.dtsi                               |   78 +++++++++++++++++++++++++++--------
 arch/arm/boot/dts/at91sam9263ek.dts                              |    5 ++-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi                      |   11 ++---
 arch/arm/boot/dts/at91sam9g45.dtsi                               |   92 ++++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/at91sam9m10g45ek.dts                           |    5 ++-
 arch/arm/boot/dts/at91sam9n12.dtsi                               |   62 +++++++++++++++++-----------
 arch/arm/boot/dts/at91sam9x25.dtsi                               |   21 ++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi                                |  100 ++++++++++++++++++++++++++++++++------------
 arch/arm/boot/dts/pm9g45.dts                                     |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig                                       |    9 ++++
 arch/arm/mach-at91/Makefile                                      |    1 +
 arch/arm/mach-at91/at91rm9200.c                                  |   18 ++++++++
 arch/arm/mach-at91/at91rm9200_time.c                             |   63 +++++++++++++++++++++++++++-
 arch/arm/mach-at91/board-rm9200-dt.c                             |   57 +++++++++++++++++++++++++
 arch/arm/mach-at91/generic.h                                     |    1 +
 arch/arm/mach-at91/setup.c                                       |   14 +++++++
 drivers/pinctrl/pinctrl-at91.c                                   |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 24 files changed, 1410 insertions(+), 142 deletions(-)
 create mode 100644 arch/arm/boot/dts/animeo_ip.dts
 create mode 100644 arch/arm/boot/dts/at91rm9200.dtsi
 create mode 100644 arch/arm/boot/dts/at91rm9200ek.dts
 create mode 100644 arch/arm/boot/dts/pm9g45.dts
 create mode 100644 arch/arm/mach-at91/board-rm9200-dt.c

Best Regards,
J.
