From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 09:05:03 +0900
Subject: [GIT PULL 2/2] ARM64: EXYNOS: mach/soc changes for v4.6, 2nd
In-Reply-To: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
References: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456445103-23314-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,


Pull request for v4.6 with ARM64 mach/soc changes.

This depends on change in clk tree (removal of ARCH_EXYNOS7) which is
pulled here.


Kind regards,
Krzysztof


Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>



The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.6-2

for you to fetch changes up to c87b3e970c70d5e27f9eb9acd09c6b5b9d589860:

  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2016-02-23 08:49:46 +0900)

----------------------------------------------------------------
Samsung Exynos ARM64 improvements for v4.6:
1. Remove separate ARCH_EXYNOS7 symbol and consolidate it into
   one ARCH_EXYNOS.
   This depends on clk tree: removal of last presence of ARCH_EXYNOS7.

----------------------------------------------------------------
Andi Shyti (4):
      clk: s2mps11: merge two for loops in one
      clk: s2mps11: allocate only one structure for clock init
      clk: s2mps11: remove redundant static variables declaration
      clk: s2mps11: remove redundant code

Axel Lin (1):
      clk: scpi: Fix checking return value of platform_device_register_simple()

Geliang Tang (1):
      clk: move the common clock's to_clk_*(_hw) macros to clk-provider.h

Heiko Stuebner (1):
      clk-divider: make sure read-only dividers do not write to their register

James Liao (2):
      clk: mediatek: Fix memory leak on clock init fail
      clk: Move vendor's Kconfig into CCF menu section

Krzysztof Kozlowski (4):
      clk: samsung: Enable COMPILE_TEST for Samsung clocks
      clk: samsung: Don't build ARMv8 clock drivers on ARMv7
      Merge branch 'clk-samsung' of git://git.kernel.org/.../clk/linux into next/soc64
      arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

Loc Ho (2):
      Documentation: Update APM X-Gene clock binding for v2 hardware
      clk: xgene: Add SoC and PMD PLL clocks with v2 hardware

Marc Gonzalez (1):
      clk: tango4: rename ARCH_TANGOX to ARCH_TANGO

Stephen Boyd (2):
      clk: mvebu: Mark ioremapped memory as __iomem
      clk: xgene: Remove return from void function

 Documentation/devicetree/bindings/clock/xgene.txt |   2 +
 arch/arm/mach-s3c24xx/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                      |  11 +--
 arch/arm64/boot/dts/exynos/Makefile               |   2 +-
 arch/arm64/configs/defconfig                      |   2 +-
 drivers/clk/Kconfig                               |   8 +-
 drivers/clk/Makefile                              |   2 +-
 drivers/clk/clk-composite.c                       |   2 -
 drivers/clk/clk-divider.c                         |  13 ++-
 drivers/clk/clk-fixed-factor.c                    |   2 -
 drivers/clk/clk-fixed-rate.c                      |   2 -
 drivers/clk/clk-fractional-divider.c              |   2 -
 drivers/clk/clk-gate.c                            |   2 -
 drivers/clk/clk-gpio.c                            |   2 -
 drivers/clk/clk-multiplier.c                      |   2 -
 drivers/clk/clk-mux.c                             |   2 -
 drivers/clk/clk-s2mps11.c                         | 108 +++++++---------------
 drivers/clk/clk-scpi.c                            |   2 +-
 drivers/clk/clk-xgene.c                           | 105 +++++++++++++--------
 drivers/clk/imx/clk-busy.c                        |   4 +-
 drivers/clk/imx/clk-fixup-div.c                   |   5 +-
 drivers/clk/imx/clk-fixup-mux.c                   |   2 -
 drivers/clk/imx/clk-gate-exclusive.c              |   2 +-
 drivers/clk/mediatek/clk-gate.c                   |   8 +-
 drivers/clk/mediatek/clk-gate.h                   |   2 +-
 drivers/clk/mediatek/clk-mtk.c                    |   6 +-
 drivers/clk/mvebu/common.c                        |   2 -
 drivers/clk/mvebu/dove-divider.c                  |   2 +-
 drivers/clk/mvebu/kirkwood.c                      |   2 -
 drivers/clk/mxs/clk-div.c                         |   2 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c                 |   4 +-
 drivers/clk/rockchip/clk.c                        |   4 +-
 drivers/clk/samsung/Kconfig                       |  19 ++--
 drivers/clk/samsung/Makefile                      |   4 +-
 drivers/clk/st/clkgen-mux.c                       |   9 +-
 drivers/clk/ti/composite.c                        |   2 -
 drivers/clk/ti/divider.c                          |   2 -
 drivers/clk/ti/gate.c                             |   2 -
 drivers/clk/ti/mux.c                              |   2 -
 include/linux/clk-provider.h                      |  19 ++++
 40 files changed, 178 insertions(+), 198 deletions(-)
