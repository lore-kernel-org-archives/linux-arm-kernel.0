From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 25 May 2012 10:24:13 +0800
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
Message-ID: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The work is based on  ci13xxx rework done by Alexander Shishkin.

Status:
  - this version only support host
  - usbotg controler works at host role

Changes since V2:
  - Rebase to Alex's tree
  - Use regulator to control vbus power
  - Remove ARCH check in Kconfig, but add OF_DEV check.
  - Other changes according laster version comments.

Richard Zhao (12):
  usb: otg: add notify_connect/notify_disconnect callback
  usb: chipidea: permit driver bindings pass phy pointer
  usb: ehci-hcd: notify phy when connect change
  usb: otg: add basic mxs phy driver support
  usb: chipidea: add imx platform driver
  ARM: imx6q: correct device name of usbphy and usb controller clock
    export
  ARM: imx6q: add config-on-boot gpios
  ARM: imx6q: add usbphy clocks
  ARM: imx6q: disable usb charger detector
  ARM: dts: imx6q-sabrelite: add usb devices
  ARM: mxs: clk_register_clkdev mx28 usb clocks
  ARM: dts: imx28-evk: add usb devices

 .../devicetree/bindings/arm/config-on-boot.txt     |   12 ++
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 ++
 Documentation/devicetree/bindings/usb/mxs-phy.txt  |   13 ++
 arch/arm/boot/dts/imx28-evk.dts                    |   36 ++++
 arch/arm/boot/dts/imx28.dtsi                       |   12 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   35 ++++
 arch/arm/boot/dts/imx6q.dtsi                       |   36 ++++-
 arch/arm/mach-imx/clk-imx6q.c                      |   12 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   59 ++++++
 drivers/clk/mxs/clk-imx28.c                        |    4 +
 drivers/usb/chipidea/Makefile                      |    3 +
 drivers/usb/chipidea/ci.h                          |    2 +
 drivers/usb/chipidea/ci13xxx_imx.c                 |  189 ++++++++++++++++++
 drivers/usb/chipidea/core.c                        |    4 +
 drivers/usb/chipidea/host.c                        |    1 +
 drivers/usb/chipidea/udc.c                         |   11 +-
 drivers/usb/host/ehci-hcd.c                        |   14 ++
 drivers/usb/otg/Kconfig                            |    8 +
 drivers/usb/otg/Makefile                           |    1 +
 drivers/usb/otg/mxs-phy.c                          |  204 ++++++++++++++++++++
 include/linux/usb/chipidea.h                       |    3 +
 include/linux/usb/otg.h                            |   21 ++
 22 files changed, 690 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/config-on-boot.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mxs-phy.txt
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
 create mode 100644 drivers/usb/otg/mxs-phy.c

-- 
1.7.5.4
