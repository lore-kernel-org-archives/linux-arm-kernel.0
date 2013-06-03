From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 23:09:56 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.10, take 2
Message-ID: <20130603150953.GA13853@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit de78a23d73ba7f1d08f3e1aeaa0a03cb912c62a0:

  ARM: imx: fix typo in gpu3d_shader_sels (2013-05-12 21:39:51 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.10-2

for you to fetch changes up to a08b9bc586a7810cdebbc316d5cbaed56a2a04a9:

  ARM: imx: clk-imx6q: AXI clock select index is incorrect (2013-06-03 13:47:12 +0800)

----------------------------------------------------------------
The imx fixes for 3.10, take 2:

- One device tree fix for all spi node to have per clock added.
  The clock is needed by spi driver to calculate bit rate divisor.
  The spi node in the current device trees either does not have the
  clock or is defined as dummy clock, in which case the driver probe
  will fail or spi will run at a wrong bit rate.

- Two imx6q clock fixes, which correct axi_sels and ldb_di_sels.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: clk-imx6q: AXI clock select index is incorrect

Jiada Wang (1):
      ARM i.MX6q: fix for ldb_di_sels

Jonas Andersson (1):
      ARM: dts: imx: fix clocks for cspi

 arch/arm/boot/dts/imx25.dtsi  |   12 ++++++------
 arch/arm/boot/dts/imx27.dtsi  |    6 +++---
 arch/arm/boot/dts/imx51.dtsi  |    2 +-
 arch/arm/boot/dts/imx53.dtsi  |    2 +-
 arch/arm/mach-imx/clk-imx6q.c |    4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)
