From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Aug 2015 12:47:08 +0800
Subject: [PATCH v2 00/10] USB: chipidea misc patches
Message-ID: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In this series, I add several new interfaces for chipidea driver,
they are mainly for system configuration adjustment. The USB
performance may be improved with these configuration changing,
but each vendor driver owner needs to consult with your IC
owner which configuration parameters are suitable for your system
before changing it, and only change it if necessary.

The other changes are for imx, it shows how imx uses these interfaces.
Shawn, the patch [5/10] and [9/10] are dts changes, help to review it
please.

Changes for v2:
- Use the bit fields which are not used. [Patch 2/10, 6/10, 10/10]
- According to Greg and Sascha comments, format patch 2/10's
  commit log.
- using non-burst instead of unburst for patch 7/10

Peter Chen (10):
  usb: chipidea: udc: zero-length packet is only needed for TX
  usb: chipidea: define stream mode disable for both roles
  usb: chipidea: imx: add stream mode enable for device mode at
    imx6sl/imx6sx
  Doc: usb: ci-hdrc-usb2: add ahb-burst-config for binding doc
  ARM: imx6: set ahb-burst-config as 0 for USB
  usb: chipidea: add ahb burst configuration interface
  usb: chipidea: usbmisc_imx: add non-burst setting for imx6
  Doc: usb: ci-hdrc-usb2: add tx(rx)-burst-config-dword for binding doc
  ARM: imx6: change default burst size for USB
  usb: chipidea: add tx/rx burst size configuration interface

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       | 10 ++++
 arch/arm/boot/dts/imx6qdl.dtsi                     | 12 +++++
 arch/arm/boot/dts/imx6sl.dtsi                      |  9 ++++
 arch/arm/boot/dts/imx6sx.dtsi                      |  9 ++++
 drivers/usb/chipidea/bits.h                        |  7 +++
 drivers/usb/chipidea/ci.h                          |  1 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 | 16 +++---
 drivers/usb/chipidea/core.c                        | 62 +++++++++++++++++++++-
 drivers/usb/chipidea/udc.c                         |  2 +-
 drivers/usb/chipidea/usbmisc_imx.c                 | 12 ++++-
 include/linux/usb/chipidea.h                       | 11 +++-
 11 files changed, 140 insertions(+), 11 deletions(-)

-- 
1.9.1
