From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:40 +0200
Subject: [PATCH 0/8] Exynos device tree clean-up for 3.12
Message-ID: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intends to fix small problems with Exynos device tree sources
that I spotted during my work on other things. The fixes are mostly
stylistic, without any funtional changes introduced, except patch 6/8,
which makes the mshc node disabled by default, but for all affected
boards it is enabled at board level.

Tomasz Figa (8):
  Documentation: devicetree: Update Exynos MCT bindings description
  ARM: dts: exynos4: Drop interrupt controller properties from MCT nodes
  ARM: dts: exynos4x12: Move MCT node to exynos4x12.dtsi
  ARM: dts: exynos4: Simplify MCT interrupt map
  ARM: dts: exynos4x12: Move mshc node to exynos4x12.dtsi
  ARM: dts: exynos4x12: Keep mshc node disabled by default
  ARM: dts: exynos: Fix missing spaces after labels
  ARM: dts: exynos4: Add missing unit-address of sysreg node

 .../bindings/timer/samsung,exynos4210-mct.txt      | 49 ++++++++++++++--------
 arch/arm/boot/dts/exynos4.dtsi                     |  6 +--
 arch/arm/boot/dts/exynos4210.dtsi                  | 23 +++++-----
 arch/arm/boot/dts/exynos4212.dtsi                  | 24 +----------
 arch/arm/boot/dts/exynos4412.dtsi                  | 36 +---------------
 arch/arm/boot/dts/exynos4x12.dtsi                  | 29 +++++++++++++
 arch/arm/boot/dts/exynos5.dtsi                     |  4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  6 +--
 arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
 9 files changed, 82 insertions(+), 97 deletions(-)

-- 
1.8.3.2
