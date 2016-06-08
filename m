From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 8 Jun 2016 12:15:09 +0800
Subject: [PATCH v3 0/2] ARM: ohci-at91: Add support to forcibly suspend ports
 while sleep
Message-ID: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To save the power consumption, add a new compatible to support forcibly
suspend the USB PORTA/B/C via OHCI Interrupt Configuration SFR Register.

Changes in v3:
 - Change the compatible description for more precise.

Changes in v2:
 - Add compatible to support forcibly suspend the ports.
 - Add soc/at91/at91_sfr.h to accommodate the defines.
 - Add error checking for .sfr_regmap.
 - Remove unnecessary regmap_read() statement.
 - Use the new compatible for ohci-node.

Wenyou Yang (2):
  usb: ohci-at91: Forcibly suspend ports while USB suspend
  ARM: at91/dt: sama5d2: Use new compatible for ohci node

 .../devicetree/bindings/usb/atmel-usb.txt          |  6 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  2 +-
 drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
 include/soc/at91/at91_sfr.h                        | 29 ++++++++
 4 files changed, 113 insertions(+), 4 deletions(-)
 create mode 100644 include/soc/at91/at91_sfr.h

-- 
2.7.4
