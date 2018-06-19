From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Tue, 19 Jun 2018 09:32:12 +0200
Subject: [PATCH 0/2] Add support for the ConnectCore 6UL SOM and SBC Express
Message-ID: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a device tree include for the ConnectCore 6UL
System-On-Module and a device tree for the ConnectCore 6UL SBC Express board
that includes it.

Not all the SOM hardware is supported in this initial patchset, specifically
the 802.11 WiFi and BT chipset and the extended functionality provided by
the on module NXP Kinetis KL03 are not supported.

The SOM is based on NXP's i.MX6UL SoC, and the patchset is tested against
v4.18-rc1.

More information about the hardware can be found at:

ConnectCore 6UL SOM:
https://www.digi.com/products/embedded-systems/system-on-modules/connectcore-for-i-mx6ul

ConnectCore 6UL SBC Express board:
https://www.digi.com/products/embedded-systems/single-board-computers/connectcore-for-i-mx6ul-sbc-express

Alex Gonzalez (2):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts | 205 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi       | 199 +++++++++++++++++++++++
 3 files changed, 405 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
