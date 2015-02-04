From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 04 Feb 2015 23:31:33 +0900
Subject: [GIT PULL 2/3] Samsung 4th DT updates for v3.20
Message-ID: <54D22D45.2090000@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is 4th DT updates for v3.20.
Please pull.

Note there are several dt updates in my tree which has a dependency with
driver side for v3.20 and I hope it can be sent to upstream via arm-soc
during late merge window. If it is OK to you guys, I'll send a pull
request soon. (example tmu, asoc and devfreq)

Thanks,
Kukjin


The following changes since commit ea08de16eb1ba2052ce2db4b58b62a2ec33357a3:

  ARM: dts: Add DISP1 power domain for exynos5420 (2015-01-29 08:52:23
+0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-4

for you to fetch changes up to 7808cae3e97140781eb3f712084caf4e44c126c9:

  ARM: dts: Add PPMU node for exynos4412-trats2 (2015-02-04 08:11:52 +0900)

----------------------------------------------------------------
Samsung 4th DT updates for v3.20

- For exynos4 SoCs
  : add PPMU node
  : add syscon phandle for video-phy node

- For exynos4415 SoC
  : add mipi dsi and fimd device nodes

- For exynos3250-monk and exynos3250-rinato boards
  : add PPMU node

- For exynos4412-trats2 board
  : add maxim77693 fuel gauge and battery charger nodes
  : fix regarding CLK_MOUT_CAMn parent and CLK_UART_ISP_SCLK clocks
  : switch max77686 regulators to GPIO control
  : add suspend configuration for max77686 regulators
  : add PPMU node and sound nodes

----------------------------------------------------------------
Chanwoo Choi (4):
      ARM: dts: Add PPMU dt node for exynos3250
      ARM: dts: Add PPMU dt node for exynos4 and exynos4210
      ARM: dts: Add PPMU node for exynos3250-monk and exynos3250-rinato
      ARM: dts: Add PPMU node for exynos4412-trats2

Inha Song (1):
      ARM: dts: Add sound nodes for exynos4412-trats2

Krzysztof Kozlowski (4):
      ARM: dts: Add Maxim 77693 fuel gauge node for exynos4412-trats2
      ARM: dts: Add suspend configuration for max77686 regulators for
exynos4412-trats2
      ARM: dts: Switch max77686 regulators to GPIO control for
exynos4412-trats2
      ARM: dts: Add max77693 charger node for exynos4412-trats2

Sylwester Nawrocki (3):
      ARM: dts: Fix CLK_UART_ISP_SCLK clock assignment in exynos4x12.dtsi
      ARM: dts: Fix CLK_MOUT_CAMn parent clocks assignment for
exynos4412-trats2
      ARM: dts: Add syscon phandle to the video-phy node for Exynos4

YoungJun Cho (2):
      ARM: dts: add fimd device node for exynos4415
      ARM: dts: add mipi dsi device node for exynos4415

 arch/arm/boot/dts/exynos3250-monk.dts   |  40 ++++++
 arch/arm/boot/dts/exynos3250-rinato.dts |  40 ++++++
 arch/arm/boot/dts/exynos3250.dtsi       |  74 +++++++++++
 arch/arm/boot/dts/exynos4.dtsi          | 109 +++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi       |   8 ++
 arch/arm/boot/dts/exynos4412-trats2.dts | 211
++++++++++++++++++++++++--------
 arch/arm/boot/dts/exynos4415.dtsi       |  27 ++++
 arch/arm/boot/dts/exynos4x12.dtsi       |   2 +-
 8 files changed, 458 insertions(+), 53 deletions(-)
