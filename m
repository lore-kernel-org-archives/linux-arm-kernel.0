From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 14:57:40 +0000
Subject: [PATCH 0/9] ARM: dts: armada388: Introduce Clearfog Base DT
References: <E1cO41M-0007xc-Id@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO43Q-0007yJ-ON@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series, based upon the previously submitted fix for the SPI
flash, reworks the Clearfog DT files to add support for the SolidRun
Clearfog Base platform.

The conventional model is now known as the "Clearfog Pro" module, which
has the DSA switch and two PCIe sockets.  The base model is a smaller
board without the DSA switch, replacing it with a second copper gigabit
port, and only one PCIe socket.

We retain the original DT file (named armada-388-clearfog.dtb) for
compatibility with existing installations - not only the filename,
but also the board name exposed in userspace.

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-388-clearfog-base.dts     |  94 ++++++
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      |  55 ++++
 arch/arm/boot/dts/armada-388-clearfog.dts          | 364 ++++-----------------
 arch/arm/boot/dts/armada-388-clearfog.dtsi         | 310 ++++++++++++++++++
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi |  21 ++
 6 files changed, 548 insertions(+), 298 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-base.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog-pro.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog.dtsi
