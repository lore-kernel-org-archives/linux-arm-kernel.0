From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 26 Jan 2017 23:46:32 +0800
Subject: [GIT PULL] i.MX fixes for 4.10, 3rd round
Message-ID: <20170126154630.GE5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 37530e74609a28ae3a3b51e7685fe54a00b1e2f2:

  ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000 pinctrl init (2017-01-10 10:51:14 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.10-3

for you to fetch changes up to a971c5545c3d45a1e33fda6e57913bb75aaa20c9:

  ARM: dts: imx: Pass 'chosen' and 'memory' nodes (2017-01-24 21:24:28 +0800)

----------------------------------------------------------------
i.MX fixes for 4.10, 3rd round:
 - Fix a 'defined but not used' warning in MMDC driver when
   CONFIG_PERF_EVENTS is disabled.
 - Fix i.MX6DL device tree GPIO4_11 range setting.
 - A bandaid fix for boot failure found on a couple of platforms due to
   missing 'chosen' and 'memory' node.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: imx: hide unused variable in #ifdef

Fabio Estevam (1):
      ARM: dts: imx: Pass 'chosen' and 'memory' nodes

S?bastien Szymanski (1):
      ARM: dts: imx6dl: fix GPIO4 range

 arch/arm/boot/dts/imx1.dtsi    | 8 ++++++++
 arch/arm/boot/dts/imx23.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx25.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx27.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx28.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx31.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx35.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx50.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx51.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx53.dtsi   | 8 ++++++++
 arch/arm/boot/dts/imx6dl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 arch/arm/boot/dts/imx6sl.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6sx.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6ul.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx7s.dtsi   | 8 ++++++++
 arch/arm/mach-imx/mmdc.c       | 2 +-
 17 files changed, 122 insertions(+), 2 deletions(-)
