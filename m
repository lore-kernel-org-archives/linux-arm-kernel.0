From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 18 Dec 2015 17:33:54 +0800
Subject: [RFC PATCH 0/5] USB: add generic onboard USB driver
Message-ID: <1450431239-16439-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is later patch set for generic onboard HUB dirver [1], since
I find it can apply for all generic onboard USB devices, so I
changed a little for it, it should be work for the use case found
at imx6qdl udoo board, but several people have comments for its
design, I mark RFC for disucssion, and see how to implement it
properly.

The purpose for this patch set is to let the USB handle platform
parameters properly, since some usb devices need to pre-setup
before it can be recognized by controller [2], some usb devices
has more interfaces for others use, like i2c, gpios, etc.[3]

Thanks.

[1] http://www.spinics.net/lists/linux-usb/msg134082.html
[2] http://www.spinics.net/lists/linux-usb/msg131502.html
[3] http://marc.info/?l=linux-usb&m=142772952730243&w=2

Peter Chen (5):
  usb: hub: add device tree support for populating onboard usb device
  doc: dt-binding: generic onboard USB device
  usb: misc: generic_onboard_hub: add generic onboard USB device driver
  usb: chipidea: host: let the hcd know's parent device node
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/usb/generic-onboard-device.txt        |  31 +++++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  35 ++---
 drivers/usb/chipidea/host.c                        |  18 ++-
 drivers/usb/core/hub.c                             |  37 ++++++
 drivers/usb/misc/Kconfig                           |  10 ++
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/generic_onboard_device.c          | 144 +++++++++++++++++++++
 8 files changed, 258 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-device.txt
 create mode 100644 drivers/usb/misc/generic_onboard_device.c

-- 
1.9.1
