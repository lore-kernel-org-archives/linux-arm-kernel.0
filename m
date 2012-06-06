From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  6 Jun 2012 12:33:12 +0200
Subject: No subject
Message-ID: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following adds i.MX53 nand support and generally devicetree
based probing for i.MX5 boards. The first three patches should go
via mtd, the last patch optionally aswell if all agree.

Sascha

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx/nand-mx53

for you to fetch changes up to d55d1479a3bfaedbb9f0c6c956f4dff6bb6d6d61:

  ARM i.MX5: Add nand oftree support (2012-06-06 12:20:24 +0200)

----------------------------------------------------------------
Sascha Hauer (4):
      mtd nand mxc_nand: Use managed resources
      mtd nand mxc_nand: swap iomem resource order
      mtd nand mxc_nand: add i.MX53 support
      ARM i.MX5: Add nand oftree support

 arch/arm/boot/dts/imx51.dtsi                  |    7 ++
 arch/arm/boot/dts/imx53.dtsi                  |    7 ++
 arch/arm/mach-imx/clk-imx51-imx53.c           |    2 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |   11 +-
 drivers/mtd/nand/mxc_nand.c                   |  137 ++++++++++++++-----------
 5 files changed, 97 insertions(+), 67 deletions(-)
