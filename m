From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 19:01:33 +0100
Subject: [PATCH v2 0/5] mvebu support for kirkwood HP T5325
Message-ID: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support to mvebu for the HP T5325 thin client.
This is the first kirkwood device using device tree which supports
audio. However the audio codec is missing a device tree binding, and
simple-audio-card does not yet quite support all the properties needed
for this hardware. So C code is used for the audio devices.

v2:
Indentation fixes, space->tab, extra spaces removed.
Split DTS into a patch of its own.

Andrew Lunn (5):
  ARM: Kirkwood: Add audio node to kirkwood.dtsi
  ARM: mvebu: Add i2c alias so setting bus number
  ARM: mvebu: Add HP T5325 thin client
  ARM: mvebu: Add dts file describing HP T5325 thin client
  ARM: mvebu: Add HP T5325 devices to {multi|mvebu}_v5_defconfig

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/kirkwood-t5325.dts | 209 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi      |  12 +-
 arch/arm/configs/multi_v5_defconfig  |   9 ++
 arch/arm/configs/mvebu_v5_defconfig  |   9 ++
 arch/arm/mach-mvebu/Kconfig          |   7 ++
 arch/arm/mach-mvebu/Makefile         |   1 +
 arch/arm/mach-mvebu/board-t5325.c    |  41 +++++++
 arch/arm/mach-mvebu/board.h          |  22 ++++
 arch/arm/mach-mvebu/kirkwood.c       |  11 +-
 10 files changed, 320 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-t5325.dts
 create mode 100644 arch/arm/mach-mvebu/board-t5325.c
 create mode 100644 arch/arm/mach-mvebu/board.h

-- 
1.8.5.3
