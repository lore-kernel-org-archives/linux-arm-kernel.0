From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 18 Jul 2012 18:29:05 +0800
Subject: [PATCH v2 0/2] imx: add usbmisc support
Message-ID: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usbmisc driver handles the SoC specific non-core usb registers.

It's based on Greg's usb-next.

Changes since last version:
 - rework to let usb-imxXXX drivers register ops callbacks

Richard Zhao (2):
  USB: chipidea: add imx usbmisc support
  ARM: dts: imx6q-sabrelite: add usbmisc device

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   12 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    4 +
 arch/arm/boot/dts/imx6q.dtsi                       |   19 ++-
 arch/arm/mach-imx/clk-imx6q.c                      |    1 +
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   23 +++
 drivers/usb/chipidea/usbmisc_imx6q.c               |  161 ++++++++++++++++++++
 8 files changed, 219 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

-- 
1.7.9.5
