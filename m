From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 Jul 2013 18:51:48 +0200
Subject: [PATCH 0/2] Support for another NSA310 
Message-ID: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are apparently three different designs of the ZyXEL NSA310 NAS
box. This patchset adds support for a second one, refactoring the
common DTS parts into a shared DTSI file.

What is not clear is naming. There is no obvious marketing name
difference, hardware version label, etc. So for the same of argument,
this new device uses the name NSA310a in DTS.

The second patch adds to the kirkwood_defconfig drivers not already in
the default configuration, plus some additional drivers used by other
kirkwood devices. The aim is to improve build test coverage.

	 Andrew


Andrew Lunn (2):
  ARM: Kirkwood: Add support for another ZyXEL NSA210 variant
  ARM: Kirkwood: update defconfig for used i2c devices, EXT4 FS, r8169

 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi |  107 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts         |  100 +--------------
 arch/arm/boot/dts/kirkwood-nsa310a.dts        |  165 +++++++++++++++++++++++++
 arch/arm/configs/kirkwood_defconfig           |   10 +-
 5 files changed, 283 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310a.dts

-- 
1.7.10.4
