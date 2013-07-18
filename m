From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 09:46:07 +0200
Subject: [RFC] Split i.MX pinctrl groups
Message-ID: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently introduce completely new pinctrl groups for each slight
variant of the pinctrl setup of a device. For several devices the
groups can be split into smaller groups to increase the flexibility
and to reduce the devicetree sizes (both source and dtb).

For example SDHC controller groups can be split into a base group
and an 8bit extension. The FEC groups can be split into base group
and several MDIO groups. The UARTs can be split into a base group
and RTS/CTS extensions.

Doing this makes the group names more obvious. Instead of having
just index _1, _2 and so on we now have base_1, 8bit_1.

This is not meant for inclusion right now, just some preliminary
patches to demonstrate the idea to see if this is acceptable/desired.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      ARM: dts: i.MX6: split enet pins into smaller groups
      ARM: dts: i.MX53: split esdhc1 pins into base and 8bit groups
      ARM: dts: i.MX53: split esdhc2 pins into base and 8bit groups
      ARM: dts: i.MX53: split esdhc3 pins into base and 8bit groups

 arch/arm/boot/dts/imx53-ard.dts            |  2 +-
 arch/arm/boot/dts/imx53-evk.dts            |  4 +--
 arch/arm/boot/dts/imx53-m53evk.dts         |  2 +-
 arch/arm/boot/dts/imx53-qsb.dts            |  4 +--
 arch/arm/boot/dts/imx53-smd.dts            |  6 ++--
 arch/arm/boot/dts/imx53-tqma53.dtsi        |  4 +--
 arch/arm/boot/dts/imx53.dtsi               | 23 ++++++++--------
 arch/arm/boot/dts/imx6dl-wandboard.dts     |  2 +-
 arch/arm/boot/dts/imx6dl.dtsi              | 31 ++++++++++-----------
 arch/arm/boot/dts/imx6q-arm2.dts           |  2 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |  2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts      |  2 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts          |  2 +-
 arch/arm/boot/dts/imx6q.dtsi               | 44 +++++++-----------------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |  2 +-
 16 files changed, 53 insertions(+), 81 deletions(-)
