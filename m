From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:44 +0200
Subject: [PATCH] i.MX dts updates
Message-ID: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains several dts updates to i.MX SoCs.

- Add iim nodes to the dts files. We do not have a driver for the
  iim in Linux, but barebox needs these
- add aliases for i2c/spi consitently. We have started it, so let's
  complete it.
- sync pinmux between i.MX6Q and i.MX6DL. These really should be kept
  in sync
- some minor cleanup stuff and additions

Sascha

----------------------------------------------------------------
Sascha Hauer (16):
      ARM: dts: i.MX6: sync imx6q and imx6dl pinmux entries
      ARM: dts: i.MX6qdl: Add compatible and clock to flexcan nodes
      ARM: dts: i.MX6qdl: Add i.MX31 compatible to gpt node
      ARM: dts: i.MX27: Add iim node
      ARM: dts: i.MX31: Add iim node
      ARM: dts: i.MX25: Add iim node
      ARM: dts: i.MX51: Add iim node
      ARM: dts: i.MX53: Add iim node
      ARM: dts: i.MX25: Add i2c and spi aliases
      ARM: dts: i.MX27: Add i2c aliases
      ARM: dts: i.MX51: Add i2c and spi aliases
      ARM: dts: i.MX53: Add i2c and spi aliases
      ARM: dts: i.MX6: Add i2c and spi aliases
      ARM: dts: i.MX51: move kpp pinmux entry
      ARM: dts: i.MX51 babbage: Add spi-cs-high property to pmic
      ARM: dts: i.MX51: Add USB host1/2 pinmux entries

 arch/arm/boot/dts/imx25.dtsi        |  21 ++++--
 arch/arm/boot/dts/imx27.dtsi        |  21 ++++--
 arch/arm/boot/dts/imx31.dtsi        |   7 ++
 arch/arm/boot/dts/imx51-babbage.dts |   1 +
 arch/arm/boot/dts/imx51.dtsi        |  76 ++++++++++++++++++----
 arch/arm/boot/dts/imx53.dtsi        |  20 ++++--
 arch/arm/boot/dts/imx6dl.dtsi       | 123 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6q.dtsi        |   3 +-
 arch/arm/boot/dts/imx6qdl.dtsi      |  25 ++++++--
 9 files changed, 258 insertions(+), 39 deletions(-)
