From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Jul 2017 21:37:06 +0200
Subject: [PATCH 0/3] ARM: bcm283x: Raspberry Pi Zero W support
Message-ID: <1500579429-9101-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the Raspberry Pi Zero W. It depends
on "ARM: bcm283x: Move the BCM2837 DT contents from arm64 to arm."

Currently there is a regression [1] in the brcmfmac driver. This hack [2]
avoids the issue and make wifi probe on RPi Zero W.

[1] - http://marc.info/?l=linux-wireless&m=150029709021719&w=2
[2] - https://github.com/lategoodbye/rpi-zero/commit/95ef5b8fbc05d9ec086970648767cafa10483622

Stefan Wahren (3):
  ARM: bcm283x: Define UART pinmuxing on board level
  dt-bindings: bcm: Add Raspberry Pi Zero W
  ARM: dts: bcm2835: Add Raspberry Pi Zero W

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  4 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  6 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  6 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  6 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  6 ++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           | 73 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  6 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  6 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              | 10 +++
 12 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts

-- 
2.7.4
