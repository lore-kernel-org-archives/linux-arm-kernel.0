From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:34:29 +0100
Subject: [GIT PULL 4/8] ARM: SoC changes for 4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <4566793.pcSu5eP4RI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 63131b636a0ec969e8b98122c1a928b5a2649d3b:

  irqchip/armada-370-xp: Do not enable it by default when ARCH_MVEBU is selected (2016-02-16 18:11:39 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to a86e56cb3910bfe6f842b31cbcfa549af76efafc:

  Merge tag 'for-v4.6/gxbb-arm64' of https://github.com/carlocaione/linux-meson into next/arm64 (2016-03-12 17:44:51 -0800)

----------------------------------------------------------------
ARM: SoC 64-bit changes for v4.6

Here's our branch of ARM64 contents for this merge window, now
containing all ARM64 changes other than device tree files.

- Various new platforms get added
  - Allwinner A64 SoC
  - Annapurna Labs Alpine SoCs
  - Broadcom Vulcan
  - Marvell Armada 3700 SoCs
  - Amlogic S905

- Various defconfig changes to enable platform specific drivers

This branch includes part of the clk git tree to resolve a build-time
dependency.

----------------------------------------------------------------
Alim Akhtar (2):
      arm64: defconfig: Enable exynos thermal config
      arm64: defconfig: Enable Samsung MFD and related configs

Andi Shyti (4):
      clk: s2mps11: merge two for loops in one
      clk: s2mps11: allocate only one structure for clock init
      clk: s2mps11: remove redundant static variables declaration
      clk: s2mps11: remove redundant code

Andre Przywara (2):
      arm64: Introduce Allwinner SoC config option
      arm64: add defconfig options for Allwinner SoCs

Andreas F?rber (1):
      ARM64: Enable Amlogic Meson GXBaby platform

Antoine Tenart (3):
      arm64: add Alpine SoC family
      arm64: defconfig: enable the Alpine family
      arm64: alpine: select the Alpine MSI controller driver

Anup Patel (1):
      arm64: Select COMMON_CLK_IPROC, PINCTRL and GPIOLIB for iProc SoCs

Arnd Bergmann (10):
      Documentation: arm: update Marvell product listing
      Merge tag 'arm-soc/for-4.6/maintainers-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'arm-soc/for-4.6/defconfig-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'arm-soc/for-4.6/soc-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'renesas-arm64-defconfig-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'renesas-arm64-soc-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'mvebu-arm64-4.6-2' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'sunxi-config64-for-4.6' of https://git.kernel.org/.../mripard/linux into next/arm64
      Merge tag 'hip05-config-for-4.6' of git://github.com/hisilicon/linux-hisi into next/arm64
      Merge tag 'samsung-defconfig-4.6-2' of git://git.kernel.org/.../krzk/linux into next/arm64

Caesar Wang (1):
      arm64: Enable the timer on Rockchip architecture

Geert Uytterhoeven (1):
      arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains

Geliang Tang (1):
      clk: move the common clock's to_clk_*(_hw) macros to clk-provider.h

Georgi Djakov (2):
      arm64: defconfig: Add Qualcomm sdhci and restart functionality
      arm64: defconfig: Increase MMC_BLOCK_MINORS to 16

Gregory CLEMENT (4):
      arm64: add mvebu architecture entry
      MAINTAINERS: Extend dts entry for ARM64 mvebu files
      Documentation: arm: update supported Marvell EBU processors
      arm64: defconfig: enable Armada 3700 related config

Heiko Stuebner (1):
      clk-divider: make sure read-only dividers do not write to their register

James Liao (2):
      clk: mediatek: Fix memory leak on clock init fail
      clk: Move vendor's Kconfig into CCF menu section

Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
      ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol

Jayachandran C (3):
      arm64: defconfig: Add Broadcom Vulcan to defconfig
      arm64: cputype info for Broadcom Vulcan
      MAINTAINERS: Add entry for Broadcom Vulcan SoC

Kefeng Wang (1):
      arm64: defconfig: Enable DesignWare APB GPIO controller

Krzysztof Kozlowski (7):
      ARM: exynos_defconfig: Enable NEON, accelerated crypto and cpufreq stats
      ARM: exynos_defconfig: Enable s5p-secss driver
      Merge tag 'rtc-max77686-4.6' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      clk: samsung: Enable COMPILE_TEST for Samsung clocks
      clk: samsung: Don't build ARMv8 clock drivers on ARMv7
      Merge branch 'clk-samsung' of git://git.kernel.org/.../clk/linux into next/soc64
      arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

Loc Ho (2):
      Documentation: Update APM X-Gene clock binding for v2 hardware
      clk: xgene: Add SoC and PMD PLL clocks with v2 hardware

Magnus Damm (1):
      arm64: renesas: Enable RENESAS_IRQC

Olof Johansson (4):
      Merge tag 'v4.6-rockchip-soc64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/arm64
      Merge tag 'mvebu-arm64-4.6-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'samsung-soc64-4.6-2' of git://git.kernel.org/.../krzk/linux into next/arm64
      Merge tag 'for-v4.6/gxbb-arm64' of https://github.com/carlocaione/linux-meson into next/arm64

Srinivas Kandagatla (1):
      arm64: defconfig: add spmi and usb related configs

Stephen Boyd (1):
      clk: xgene: Remove return from void function

Thomas Petazzoni (4):
      Documentation: arm: improve Armada 37xx description
      Documentation: arm: add link to Armada 38x Functional Spec
      Documentation: arm: add Marvell Armada 7K and 8K families
      arm64: update ARCH_MVEBU for Marvell Armada 7K/8K support

Yoshihiro Shimoda (1):
      arm64: defconfig: Add Renesas R-Car Gen3 USB 2.0 phy driver support

Zi Shen Lim (1):
      arm64: Broadcom Vulcan support

 Documentation/arm/Marvell/README                  | 165 ++++++++++++++++++----
 Documentation/devicetree/bindings/clock/xgene.txt |   2 +
 MAINTAINERS                                       |   8 ++
 arch/arm/configs/exynos_defconfig                 |  10 +-
 arch/arm/configs/multi_v7_defconfig               |   1 -
 arch/arm/mach-s3c24xx/Kconfig                     |   1 +
 arch/arm64/Kconfig.platforms                      |  52 +++++--
 arch/arm64/boot/dts/broadcom/Makefile             |   1 +
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts      |  33 +++++
 arch/arm64/boot/dts/broadcom/vulcan.dtsi          | 144 +++++++++++++++++++
 arch/arm64/boot/dts/exynos/Makefile               |   2 +-
 arch/arm64/configs/defconfig                      |  41 +++++-
 arch/arm64/include/asm/cputype.h                  |   3 +
 drivers/clk/Kconfig                               |   8 +-
 drivers/clk/clk-composite.c                       |   2 -
 drivers/clk/clk-divider.c                         |  13 +-
 drivers/clk/clk-fixed-factor.c                    |   2 -
 drivers/clk/clk-fixed-rate.c                      |   2 -
 drivers/clk/clk-fractional-divider.c              |   2 -
 drivers/clk/clk-gate.c                            |   2 -
 drivers/clk/clk-gpio.c                            |   2 -
 drivers/clk/clk-multiplier.c                      |   2 -
 drivers/clk/clk-mux.c                             |   2 -
 drivers/clk/clk-s2mps11.c                         | 108 ++++----------
 drivers/clk/clk-xgene.c                           | 105 +++++++++-----
 drivers/clk/imx/clk-busy.c                        |   4 +-
 drivers/clk/imx/clk-fixup-div.c                   |   5 +-
 drivers/clk/imx/clk-fixup-mux.c                   |   2 -
 drivers/clk/imx/clk-gate-exclusive.c              |   2 +-
 drivers/clk/mediatek/clk-gate.c                   |   8 +-
 drivers/clk/mediatek/clk-gate.h                   |   2 +-
 drivers/clk/mediatek/clk-mtk.c                    |   6 +-
 drivers/clk/mvebu/common.c                        |   2 -
 drivers/clk/mvebu/kirkwood.c                      |   2 -
 drivers/clk/mxs/clk-div.c                         |   2 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c                 |   4 +-
 drivers/clk/rockchip/clk.c                        |   4 +-
 drivers/clk/samsung/Kconfig                       |  19 ++-
 drivers/clk/samsung/Makefile                      |   4 +-
 drivers/clk/st/clkgen-mux.c                       |   9 +-
 drivers/clk/ti/composite.c                        |   2 -
 drivers/clk/ti/divider.c                          |   2 -
 drivers/clk/ti/gate.c                             |   2 -
 drivers/clk/ti/mux.c                              |   2 -
 include/linux/clk-provider.h                      |  19 +++
 45 files changed, 589 insertions(+), 226 deletions(-)
