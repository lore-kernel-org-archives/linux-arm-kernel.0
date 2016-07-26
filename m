From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 26 Jul 2016 18:53:27 +0000
Subject: =?UTF-8?q?=5BPATCH=20V2=20RFC=200/6=5D=20ARM=3A=20dts=3A=20bcm2835=3A=20Add=20Raspberry=20Pi=20Zero?=
Message-ID: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is only a draft and not intended to be merged. Patches 1 and 2
aren't bcm2835 specific and should be helpful for other platforms. 
The patches 2 - 4 are required for otg / gadget mode. The last patch
based on the work of Lubomir Rintel [1] and Noralf Tr?nnes [2].

Changes since V1:
- rebase to current linux-next
- add patches 1 - 4 for otg/gadget support
- add patch 5 with model compatible
- use polarity define for ACT LED

[1] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-February/003221.html
[2] - https://github.com/raspberrypi/linux/pull/1239/

Stefan Wahren (6):
  usb: dwc2: core: Avoid nonsense error in gadget mode
  usb: dwc2: Add DT properties to specify fifo size in host/otg mode
  ARM: dts: bcm283x: Add missing usb clock
  ARM: dts: bcm283x: Add generic USB PHY
  DT: bindings: bcm: Add Raspberry Pi Zero
  ARM: dts: bcm2835: Add Raspberry Pi Zero

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |    4 ++
 Documentation/devicetree/bindings/usb/dwc2.txt     |    3 ++
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   57 ++++++++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi                     |   15 ++++++
 drivers/usb/dwc2/core.c                            |   35 +++++++++---
 6 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero.dts

-- 
1.7.9.5
