From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 Apr 2014 16:17:12 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.15
Message-ID: <20140415081710.GB2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.15

for you to fetch changes up to 4591b13289b54fb5cbce84ee170f7390c576ef8f:

  ARM: i.MX6: ipu_di_sel clocks can set parent rates (2014-04-15 11:13:22 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.15:
 - A couple of dts changes for the fallout of imx-drm binding update
 - Parent DI clocks to video PLL for better HDMI support
 - PCIe interrupt mapping and GIC node fixes
 - A series of edmqmx6 board fixes
 - Other small and random fixes on imx5 and imx6 dts

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: dts: imx53-qsb-common: Fix memory region description
      ARM: dts: imx53-m53evk: Fix memory region description
      ARM: dts: imx6sl-evk: Add an entry for MX6SL_PAD_ECSPI1_SS0__GPIO4_IO11

Lothar Wa?mann (1):
      ARM: dts: imx53: fix apparent copy/paste error

Lucas Stach (7):
      ARM: dts: imx6: add PCIe interrupt mapping properties
      ARM: dts: imx: drop invalid size and address cells properties
      ARM: imx6q-clk: parent lvds_gate from lvds_sel
      ARM: dts: imx6: edmqmx6: Fix usbotg id pin
      ARM: dts: imx6: edmqmx6: USB H1 only supports host mode
      ARM: dts: imx6: edmqmx6: add second STMPE
      ARM: dts: vybrid: drop address and size cells from GIC node

Philipp Zabel (1):
      ARM: i.MX6: ipu_di_sel clocks can set parent rates

Russell King (1):
      ARM: dt: microsom: don't set bit 7 for ethernet mux settings

Sascha Hauer (2):
      ARM: dts: imx6: edmqmx6: Do not use the OTG switch as VBUS regulator
      ARM: imx6q: clk: Parent DI clocks to video PLL via di_pre_sel

Shawn Guo (3):
      ARM: dts: imx53-tx53: add IPU DI ports and endpoints
      ARM: dts: imx6q-gw5xxx: remove dead 'crtcs' property
      ARM: dts: imx: add required #clock-cells for fixed-clock

Stefan Agner (1):
      ARM: dts: mx5: fix wrong stmpe-ts bindings

 arch/arm/boot/dts/imx25.dtsi                   |  1 +
 arch/arm/boot/dts/imx27-apf27.dts              |  1 +
 arch/arm/boot/dts/imx27.dtsi                   |  1 +
 arch/arm/boot/dts/imx50.dtsi                   |  4 +++
 arch/arm/boot/dts/imx51.dtsi                   |  4 +++
 arch/arm/boot/dts/imx53-m53evk.dts             | 23 ++++++------
 arch/arm/boot/dts/imx53-qsb-common.dtsi        |  3 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts          | 11 +++++-
 arch/arm/boot/dts/imx53.dtsi                   |  6 +++-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts        | 48 +++++++++++++++++++-------
 arch/arm/boot/dts/imx6q-gw5400-a.dts           |  3 --
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi          |  3 --
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 22 ++++++------
 arch/arm/boot/dts/imx6qdl.dtsi                 | 13 +++++--
 arch/arm/boot/dts/imx6sl-evk.dts               |  1 +
 arch/arm/boot/dts/imx6sl.dtsi                  |  4 +--
 arch/arm/boot/dts/vf610-twr.dts                |  2 ++
 arch/arm/boot/dts/vf610.dtsi                   |  4 +--
 arch/arm/mach-imx/clk-imx6q.c                  | 29 ++++++++++------
 19 files changed, 123 insertions(+), 60 deletions(-)
