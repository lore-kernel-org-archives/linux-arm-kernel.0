From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:16 +0800
Subject: [PATCH v1 0/7] preliminary work for adding imx6q_sabrelite usb support
Message-ID: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The work is based on usb-next which includes ci13xxx rework by Alexander Shishkin.

Status:
  - this version only tested host
  - usbotg controler works at host role

Todo:
  - usbh1 has strange system error when enumerate devices for on-board hub.
  - high speed usb connecton detect failed for the second time. It needs hub code hack.

Thanks Peter Chen for greate help.

Richard Zhao (7):
  usb: chipidea: permit user select USB_EHCI_ROOT_HUB_TT
  usb: chipidea: remove zero check of hw_ep_max
  usb: chipidea: add imx on-soc utmi phy driver
  usb: chipidea: add imx driver binding
  ARM: imx6q: correct device name of usbphy and usboh3 clock export
  ARM: imx6q: add anatop initialization for usb controllers
  ARM: dts: imx6q-sabrelite: add usb devices

 arch/arm/boot/dts/imx6q-sabrelite.dts |   19 ++++-
 arch/arm/boot/dts/imx6q.dtsi          |   44 ++++++++-
 arch/arm/mach-imx/clk-imx6q.c         |    7 +-
 arch/arm/mach-imx/mach-imx6q.c        |   60 +++++++++++
 drivers/usb/chipidea/Makefile         |    4 +
 drivers/usb/chipidea/ci13xxx_imx.c    |  177 +++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/core.c           |    2 +-
 drivers/usb/chipidea/phy-imx-utmi.c   |  140 ++++++++++++++++++++++++++
 drivers/usb/host/Kconfig              |    2 +-
 9 files changed, 449 insertions(+), 6 deletions(-)
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
 create mode 100644 drivers/usb/chipidea/phy-imx-utmi.c

-- 
1.7.5.4
