From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:35 +0200
Subject: [PATCH 00/17] LPC18xx DTS changes for 4.3
Message-ID: <1436881192-23930-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds DT nodes for all the drivers that went upstream
in 4.2 and should represent the bulk of DTS changes for 4.3.  All
nodes added are documented and some of patches carries a ack from
subsystem maintainer. It also features updates to the EA4357 dev-
kit and a new board from Ezequiel Garcia.

Note that there might be one more batch of DTS changes for 4.3 if
any new drivers goes upstream and also some changes for the Hitex
eval board might come.

Patches also available on:
https://github.com/manabian/linux-lpc.git lpc18xx_43xx_dts_4.3


Ezequiel Garcia (2):
  of: add vendor prefix for CIAA project
  ARM: dts: add DT for CIAA LPC4337 industrial computer

Joachim Eastwood (15):
  ARM: dts: lpc18xx: add cgu and ccu clock-controller nodes
  ARM: dts: lpc18xx: add uart new compat string and clk names
  ARM: dts: lpc18xx: add pinctrl node
  ARM: dts: lpc18xx: add gpio node
  ARM: dts: lpc18xx: add ssp nodes
  ARM: dts: lpc18xx: add can nodes
  ARM: dts: lpc18xx: add mmcsd node
  ARM: dts: lpc18xx: add creg (syscon) node
  ARM: dts: lpc18xx: add ethernet node
  ARM: dts: lpc18xx: add usb nodes
  ARM: dts: lpc4357-ea4357: add pinctrl and uart0 muxing
  ARM: dts: lpc4357-ea4357: add mmcsd
  ARM: dts: lpc4357-ea4357: add gpio joystick
  ARM: dts: lpc4357-ea4357: add ethernet
  ARM: dts: lpc4357-ea4357: add uart3

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/lpc18xx.dtsi                     | 235 +++++++++++++++++++--
 arch/arm/boot/dts/lpc4337-ciaa.dts                 | 187 ++++++++++++++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |   4 -
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        | 214 +++++++++++++++++++
 6 files changed, 620 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/lpc4337-ciaa.dts

-- 
1.8.0
