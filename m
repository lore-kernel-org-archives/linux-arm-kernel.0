From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 May 2017 18:44:35 +0200
Subject: [PATCH 0/4] ARM: dts: bcm2835-rpi-zero: Enable OTG mode
Message-ID: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable OTG mode for Raspberry Pi Zero because dwc2 driver
has been fixed now.

Patch 1 adds a new dtsi file to setup OTG mode (could also be used for boards
like RPi Zero W or the Compute Module). The second patch adds the USB PHY and
was part of Raspberry Pi Zero support patch series before split up [1].
The enabling of OTG mode of RPi Zero is done by patch number 3. The last patch
updates the BCM2835 defconfig.

[1] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-July/004153.html

Stefan Wahren (4):
  ARM: dts: bcm283x: Add dtsi for OTG mode
  ARM: dts: bcm283x: Add generic USB PHY
  ARM: dts: bcm2835-rpi-zero: Enable OTG mode
  ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support

 arch/arm/boot/dts/bcm2835-rpi-zero.dts     |  2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi | 10 ++++++++++
 arch/arm/boot/dts/bcm283x.dtsi             |  6 ++++++
 arch/arm/configs/bcm2835_defconfig         |  8 ++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi

-- 
2.7.4
