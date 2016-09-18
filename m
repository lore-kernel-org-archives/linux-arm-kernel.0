From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 18:39:47 +0200
Subject: [GIT PULL 2/3] ARM: dts: exynos: DT for v4.9, second round
In-Reply-To: <1474216788-17282-1-git-send-email-krzk@kernel.org>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
Message-ID: <1474216788-17282-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>


The following changes since commit 05b01dd936b46f2c3cfbb10bc89c0ec79c745e5d:

  ARM: dts: exynos: Use 'hpd-gpios' instead of 'hpd-gpio' (2016-08-24 21:09:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.9-2

for you to fetch changes up to 5271d002709e8ca27232ab031f35e0df1d0fe4ed:

  ARM: dts: s5p: Add missing unit name to memory nodes for S5PV210 boards (2016-09-16 09:17:00 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.9, second round:
1. Enable HDMI on Arndale Octa board.
2. Update list of clocks for FIMC-IS block on Exynos4x12.
3. Remove skeleton.dtsi thus fixing DT compiler warning:
	"Node /memory has a reg or ranges property, but no unit name"
   This is a tree-wide effort by various people. Javier Martinez Canillas did
   it for Exynos and S5PV210.

----------------------------------------------------------------
Javier Martinez Canillas (9):
      ARM: dts: exynos: Add missing memory node for Exynos5440 boards
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos3
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos4
      ARM: dts: exynos: Remove skeleton.dtsi usage for Exynos5
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos3 DTS
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos4 DTS
      ARM: dts: exynos: Add missing unit name to memory nodes in Exynos5 DTS
      ARM: dts: s5p: Remove skeleton.dtsi inclusion for S5PV210
      ARM: dts: s5p: Add missing unit name to memory nodes for S5PV210 boards

Marek Szyprowski (1):
      ARM: dts: exynos: Add all required FIMC-IS clocks to exynos4x12

Milo Kim (1):
      ARM: dts: exynos: Enable HDMI for Arndale Octa board

 arch/arm/boot/dts/exynos3250-artik5.dtsi           |  3 ++-
 arch/arm/boot/dts/exynos3250-monk.dts              |  3 ++-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  3 ++-
 arch/arm/boot/dts/exynos3250.dtsi                  |  3 ++-
 arch/arm/boot/dts/exynos4.dtsi                     |  3 ++-
 arch/arm/boot/dts/exynos4210-origen.dts            |  3 ++-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  3 ++-
 arch/arm/boot/dts/exynos4210-trats.dts             |  3 ++-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  3 ++-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  3 ++-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  3 ++-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |  3 ++-
 arch/arm/boot/dts/exynos4412-origen.dts            |  3 ++-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  3 ++-
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |  3 ++-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  3 ++-
 arch/arm/boot/dts/exynos4415.dtsi                  |  3 ++-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  5 ++++-
 arch/arm/boot/dts/exynos5.dtsi                     |  3 ++-
 arch/arm/boot/dts/exynos5250-arndale.dts           |  3 ++-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  3 ++-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  3 ++-
 arch/arm/boot/dts/exynos5250-spring.dts            |  3 ++-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |  3 ++-
 arch/arm/boot/dts/exynos5260.dtsi                  |  4 ++--
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  3 ++-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  3 ++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 16 +++++++++++++++-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  3 ++-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  3 ++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  3 ++-
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |  6 ++++++
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  6 ++++++
 arch/arm/boot/dts/exynos5440.dtsi                  |  3 ++-
 arch/arm/boot/dts/exynos54xx.dtsi                  |  1 -
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  3 ++-
 arch/arm/boot/dts/s5pv210-aquila.dts               |  2 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |  2 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts             |  2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |  2 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts             |  2 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |  4 +++-
 42 files changed, 101 insertions(+), 41 deletions(-)
