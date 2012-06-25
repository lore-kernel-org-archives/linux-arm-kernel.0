From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 25 Jun 2012 14:56:17 +0800
Subject: [PATCH v7 00/14] add imx usb driver based on Greg next tree
Message-ID: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The work is based on  ci13xxx rework done by Alexander Shishkin.

To let Greg pick up, I also added patches Alex queued that I depends on.
Patch #1 - #9 : It can also be found at
http://github.com/virtuoso/linux-ci.git ci

This patch series can also be found at:
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

Status:
  - this version only support host
  - usbotg controler works at host role

Changes since last version:
 - use platform_device_unregister in ci13xxx_remove_device
 - fix build error of udc driver

Alexander Shishkin (1):
  usb: chipidea: remove unneeded NULL check

Felipe Balbi (3):
  usb: chipidea: drop useless arch-check
  usb: chipidea: msm: add missing section annotation
  usb: chipidea: msm: add remove method

Richard Zhao (10):
  USB: Chipidea: rename struct ci13xxx_udc_driver to struct
    ci13xxx_platform_data
  USB: Chipidea: rename struct ci13xxx variables from udc to ci
  USB: Chipidea: add unified ci13xxx_{add,remove}_device for platform
    drivers
  USB: Chipidea: add ci13xxx device id management
  usb: chipidea: select USB_EHCI_ROOT_HUB_TT in USB_CHIPIDEA_HOST of
    Kconfig
  usb: otg: add notify_connect/notify_disconnect callback
  USB: notify phy when root hub port connect change
  usb: chipidea: permit driver bindings pass phy pointer
  usb: otg: add basic mxs phy driver support
  usb: chipidea: add imx platform driver

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 +
 Documentation/devicetree/bindings/usb/mxs-phy.txt  |   13 +
 drivers/usb/chipidea/Kconfig                       |    1 +
 drivers/usb/chipidea/Makefile                      |    9 +-
 drivers/usb/chipidea/ci.h                          |   32 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |  197 ++++++
 drivers/usb/chipidea/ci13xxx_msm.c                 |   62 +-
 drivers/usb/chipidea/ci13xxx_pci.c                 |   52 +-
 drivers/usb/chipidea/core.c                        |   70 ++-
 drivers/usb/chipidea/debug.c                       |  146 ++---
 drivers/usb/chipidea/host.c                        |    3 +-
 drivers/usb/chipidea/udc.c                         |  636 ++++++++++----------
 drivers/usb/core/hub.c                             |    8 +
 drivers/usb/otg/Kconfig                            |    9 +
 drivers/usb/otg/Makefile                           |    1 +
 drivers/usb/otg/mxs-phy.c                          |  197 ++++++
 include/linux/usb/chipidea.h                       |   14 +-
 include/linux/usb/otg.h                            |   21 +
 18 files changed, 1000 insertions(+), 491 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mxs-phy.txt
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
 create mode 100644 drivers/usb/otg/mxs-phy.c

-- 
1.7.9.5
