From: richard.zhao@freescale.com (Richard Zhao)
Date: Sat, 7 Jul 2012 22:56:39 +0800
Subject: [PATCH v9 REBASE 0/9] add imx usb driver based on Greg next tree
Message-ID: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The work is based on  ci13xxx rework done by Alexander Shishkin.

To let Greg pick up, I also added patches Alex queued that I depends on.

This patch series can also be found at:
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

Status:
  - this version only support host
  - usbotg controler works at host role

Changes since last version:
 - Rebase patch that Greg failed to merge.


Richard Zhao (9):
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

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |   18 +
 Documentation/devicetree/bindings/usb/mxs-phy.txt  |   13 +
 drivers/usb/chipidea/Kconfig                       |    1 +
 drivers/usb/chipidea/Makefile                      |    3 +
 drivers/usb/chipidea/ci.h                          |   28 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |  198 ++++++
 drivers/usb/chipidea/ci13xxx_msm.c                 |   46 +-
 drivers/usb/chipidea/ci13xxx_pci.c                 |   34 +-
 drivers/usb/chipidea/core.c                        |   58 ++
 drivers/usb/chipidea/debug.c                       |  146 ++---
 drivers/usb/chipidea/host.c                        |    1 +
 drivers/usb/chipidea/udc.c                         |  631 ++++++++++----------
 drivers/usb/core/hub.c                             |    8 +
 drivers/usb/otg/Kconfig                            |   10 +
 drivers/usb/otg/Makefile                           |    1 +
 drivers/usb/otg/mxs-phy.c                          |  186 ++++++
 include/linux/usb/chipidea.h                       |   12 +-
 include/linux/usb/otg.h                            |   21 +
 18 files changed, 953 insertions(+), 462 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/mxs-phy.txt
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
 create mode 100644 drivers/usb/otg/mxs-phy.c

-- 
1.7.9.5
