From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 09:49:24 +0100
Subject: [PATCH 0/9 v2] at91 USB DT support
Message-ID: <20120307084924.GK21255@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	this is a second version of the patch series to add DT suport for
	usb host and device on at91


The following changes since commit 3370718be26d86e7f8587390eee563c289542ee7:

  ARM: at91/dt: add Calao DAB-MMX daugther board support for USB-A9G20 (2012-03-02 00:46:21 +0800)

are available in the git repository at:
  git at github.com:at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (9):
      ARM: at91: usb ohci add dt support
      ARM: at91: dt: enable usb ohci for sam9g20, sam9g45 amd sam9x5
      ARM: at91: usb ehci add dt support
      ARM: at91: dt: enable usb ehci for sam9g45 and sam9x5
      USB: at91: Device udc add dt support
      ARM: at91: sam9g20 udc add dt support
      usb: add Atmel USBA UDC DT support
      ARM: at91: sam9g45 add udc DT support
      ARM: at91: sam9x5 add udc DT support

 .../devicetree/bindings/usb/atmel-usb.txt          |  135 +++++++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   14 ++
 arch/arm/boot/dts/at91sam9g25ek.dts                |   17 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   80 ++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   15 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   81 ++++++++
 arch/arm/boot/dts/usb_a9g20.dts                    |   10 +
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9g45.c                   |    4 +
 arch/arm/mach-at91/at91sam9x5.c                    |    7 +-
 drivers/usb/Kconfig                                |    2 +-
 drivers/usb/gadget/Kconfig                         |    4 +-
 drivers/usb/gadget/at91_udc.c                      |   40 ++++-
 drivers/usb/gadget/atmel_usba_udc.c                |  209 +++++++++++++++-----
 drivers/usb/gadget/atmel_usba_udc.h                |    1 +
 drivers/usb/host/ehci-atmel.c                      |   24 +++-
 drivers/usb/host/ohci-at91.c                       |  101 ++++++++++-
 17 files changed, 688 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/atmel-usb.txt

Best Regards,
J.
