From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:23:22 +0100
Subject: [PATCH] i.MX IPU SoC support
Message-ID: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the necessary i.MX SoC stuff to make the IPU support
usable. Basically needed are the IPU devices in the devicetrees. This
series also adds display support for the i.MX51 babbage which then is
the first board for which the IPU driver works without out of tree
stuff.

Shawn, I already sent the MIPI setup patch some time ago. From what
I read I think we can agree on the approach on just setting the correct
register values in the SoC code, right?

Sascha

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git ipu

for you to fetch changes up to f774f0f776e282d6e0eb67dbf00703ed79b8bca2:

  ARM i.MX51 babbage: Add display support (2012-11-12 16:16:19 +0100)

----------------------------------------------------------------
Sascha Hauer (6):
      ARM i.MX51: setup MIPI during startup
      ARM i.MX5: switch IPU clk support to devicetree bindings
      ARM i.MX53: Add IPU support
      ARM i.MX51: Add IPU support
      ARM i.MX6: Add IPU support
      ARM i.MX51 babbage: Add display support

Steffen Trumtrar (1):
      ARM i.MX6: fix ldb_di_sel mux

 arch/arm/boot/dts/imx51-babbage.dts |   16 +++++++++
 arch/arm/boot/dts/imx51.dtsi        |   67 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi        |    7 ++++
 arch/arm/boot/dts/imx6q.dtsi        |   18 ++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c |   19 +++++-----
 arch/arm/mach-imx/clk-imx6q.c       |    2 +-
 arch/arm/mach-imx/mm-imx5.c         |   20 +++++++++++
 7 files changed, 140 insertions(+), 9 deletions(-)
