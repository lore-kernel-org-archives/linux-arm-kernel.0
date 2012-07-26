From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Jul 2012 18:35:13 +0800
Subject: [PATCH v3 0/3] imx: add usbmisc support
Message-ID: <1343298916-11101-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usbmisc driver handles the SoC specific non-core usb registers.

Changes since last version:
 - build usbmisc drivers into ci13xxx-imx module if it's chosen.
 - interprete properties in common code
 - check wether usbmisc_ops is null
 - dts: enable usbmisc device by default
 - take clk changes as a seperate patch

Richard Zhao (3):
  USB: chipidea: add imx usbmisc support
  ARM: dts: imx6q-sabrelite: add usbmisc device
  ARM: imx6q: clk_register_clkdev usbmisc clock

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   12 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |   18 ++-
 arch/arm/mach-imx/clk-imx6q.c                      |    1 +
 drivers/usb/chipidea/Makefile                      |    3 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   72 ++++++++-
 drivers/usb/chipidea/usbmisc_imx6q.c               |  155 ++++++++++++++++++++
 8 files changed, 258 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

-- 
1.7.9.5
