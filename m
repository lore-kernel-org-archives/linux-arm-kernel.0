From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 1 Aug 2012 15:12:18 +0800
Subject: [PATCH v5 0/3] imx: add usbmisc support
Message-ID: <1343805141-5872-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usbmisc driver handles the SoC specific non-core usb registers.

Changes since last version:
 - add missing ci13xxx_imx.h

Changes v3 -> v4:
 - rebase onto torvalds latest git tree
 - use phandle linke usb controllers and usbmisc device.
   It also make usbmisc driver possible to be kernel modules.

Richard Zhao (3):
  USB: chipidea: add imx usbmisc support
  ARM: imx6q: clk_register_clkdev usbmisc clock
  ARM: dts: imx6q-sabrelite: add usbmisc device

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   14 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   10 ++
 arch/arm/mach-imx/clk-imx6q.c                      |    1 +
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   64 ++++++++
 drivers/usb/chipidea/ci13xxx_imx.h                 |   28 ++++
 drivers/usb/chipidea/usbmisc_imx6q.c               |  162 ++++++++++++++++++++
 9 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.h
 create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

-- 
1.7.9.5
