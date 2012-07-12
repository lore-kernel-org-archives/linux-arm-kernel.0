From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:40 +0800
Subject: [PATCH 00/12] chipidea/imx: add otg support and some bug fix
Message-ID: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is tested on imx6q_sabrelite board.

The patch can also be found at
https://github.com/riczhao/kernel-imx/commits/topics/usb-driver

For test which merged platform patches:
https://github.com/riczhao/kernel-imx/commits/topics/usb-test

It's better apply after patch I sent out:
usb: chipidea: cleanup dma_pool if udc_start() fails

Richard Zhao (12):
  USB: chipidea: imx: add pinctrl support
  USB: chipidea: delay 2ms before read ID status at probe time
  USB: chipidea: move OTGSC_IDIS clearing from ci_role_work to irq
    handler
  USB: chipidea: clear gadget struct at udc_start fail path
  USB: chipidea: don't let probe fail if otg controller start one role
    failed
  USB: mxs-phy: add basic otg support
  USB: chipidea: add vbus detect for udc
  USB: chipidea: convert to use devm_request_irq
  USB: chipidea: add -DDEBUG if CONFIG_USB_CHIPIDEA_DEBUG
  USB: chipidea: add set_vbus_power support
  USB: chipidea: re-order irq handling to avoid unhandled irq
  USB: chipidea: add imx usbmisc support

 .../devicetree/bindings/usb/imx-usbmisc.txt        |   15 ++
 drivers/usb/chipidea/Makefile                      |    4 +-
 drivers/usb/chipidea/ci.h                          |    1 +
 drivers/usb/chipidea/ci13xxx_imx.c                 |   50 +++++--
 drivers/usb/chipidea/core.c                        |   36 +++--
 drivers/usb/chipidea/host.c                        |    8 ++
 drivers/usb/chipidea/imx_usbmisc.c                 |  144 ++++++++++++++++++++
 drivers/usb/chipidea/udc.c                         |   40 +++++-
 drivers/usb/otg/mxs-phy.c                          |   21 +++
 include/linux/usb/chipidea.h                       |    2 +
 10 files changed, 293 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/imx-usbmisc.txt
 create mode 100644 drivers/usb/chipidea/imx_usbmisc.c

-- 
1.7.9.5
