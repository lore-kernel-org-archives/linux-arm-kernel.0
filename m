From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Feb 2016 15:20:29 +0900
Subject: [PATCH v5 0/3] arm64/clk: EXYNOS: Consolidate Exynos7 symbol
Message-ID: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patchset attempts to remove the ARCH_EXYNOS7 symbol.

I rebased this on top of James':
 - clk: Move vendor's Kconfig into CCF menu section
   http://www.spinics.net/lists/devicetree/msg111953.html

The third patch depends on previous ones so one way of merging this
would be to prepare a tag from clk tree with first two patches
and the dependency. The last third patch would go through arm-soc.

Changes since v4:
=================
1. Rebased on "clk: Move vendor's Kconfig into CCF menu section"
   existing in clock tree.
2. Re-work patch 2/3 (see specific changelog).

Changes since v3:
=================
1. Rebase on next-20160127 (s3c64xx became multiplatform).

Changes since v2:
=================
1. Follow Arnd's advice about not enabling silently the newly added
   EXYNOS_ARM64_COMMON_CLK, when COMPILE_TEST is enabled. This was
   also a trigger for some changes in placement of Samsung clocks
   Kconfig entries...
2. ... which lead to introducing patch 1.


Rationale:
==========
We don't need ARCH_EXYNOS7 symbol because all ARMv8 platforms should
fall under generic ARCH_EXYNOS. In the same time there is no sense
in building clocks for these ARMv8 SoCs on ARMv7 builds.


Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  clk: samsung: Enable COMPILE_TEST for Samsung clocks
  clk: samsung: Don't build ARMv8 clock drivers on ARMv7
  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

 arch/arm64/Kconfig.platforms        | 11 ++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 drivers/clk/samsung/Kconfig         | 18 +++++++++++++-----
 drivers/clk/samsung/Makefile        |  4 ++--
 5 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.5.0
