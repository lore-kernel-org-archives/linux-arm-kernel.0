From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 8 Dec 2015 09:37:47 +0800
Subject: [PATCH 0/3] USB: add generic onboard USB HUB driver
Message-ID: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

There is a known issue that the USB code can't handle USB HUB's
external pins well, in that case, it may cause some onboard
USB HUBs can't work since their PHY's clock or reset pin needs to
operate.

The user reported this issue at below:
http://www.spinics.net/lists/linux-usb/msg131502.html

In this patch set, I add a generic onboard USB HUB driver to
handle this problem, the external signals will be configured
before usb controller's initialization, it much likes we did
it at board code before.

The user needs to add this generic hub node at dts or add releted
platform data to support it.

The udoo users, help to test please.

Peter Chen (3):
  usb: misc: generic_onboard_hub: add generic onboard USB HUB driver
  doc: dt-binding: generic onboard USB HUB
  ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property

 .../bindings/usb/generic-onboard-hub.txt           |  28 ++++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  25 +---
 drivers/usb/misc/Kconfig                           |   9 ++
 drivers/usb/misc/Makefile                          |   1 +
 drivers/usb/misc/generic_onboard_hub.c             | 162 +++++++++++++++++++++
 include/linux/usb/generic_onboard_hub.h            |  11 ++
 7 files changed, 224 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
 create mode 100644 drivers/usb/misc/generic_onboard_hub.c
 create mode 100644 include/linux/usb/generic_onboard_hub.h

-- 
1.9.1
