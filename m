From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 15:10:51 +0100
Subject: [PATCH 0/4] ARM: bcm2835-rpi-zero-w: Enable Bluetooth support
Message-ID: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small patch series enable the on-board Bluetooth support on the
Raspberry Pi Zero W.

I suggest that the hci_bcm patch (regression fix) goes into bluetooth-fixes.

Note: For Bluetooth support it necessary to have a firmware located at:

/lib/firmware/brcm/BCM43430A1.hcd

Stefan Wahren (4):
  Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional
  ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
  ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
  ARM: bcm2385_defconfig: Enable BT support for BCM43438

 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
 arch/arm/boot/dts/bcm283x.dtsi           |  3 +++
 arch/arm/configs/bcm2835_defconfig       |  4 ++++
 drivers/bluetooth/hci_bcm.c              |  8 +++++---
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.7.4
