From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Oct 2017 16:05:31 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20171004230531.no6ffillilvdbud5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

A slightly noisy fixes request this time. Explanation below. Please merge.


Thanks!

-Olof


The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 08f8c8808c924162d8f121a7f669d5dfe67bb51a:

  Merge tag 'stm32-dt-fixes-for-v4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into fixes (2017-10-04 10:31:00 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.14-rc

Our first batch of fixes this release cycle, unfortunately a bit noisier
than usual. Two major groups stand out:

 - Some pinctril dts/dtsi changes for stm32 due to a new driver being
   merged during the merge window, and this aligns the DT contents between
   the old format and the new. This could arguably be moved to the next
   merge window but it also seemed relatively harmless to include now.

 - Amlogic/meson had driver changes merged that required devicetree
   changes to avoid functional/performance regressions. I've already
   asked them to be more careful about this going forward, and making
   sure drivers are compatible with older DTs when they make these kind
   of changes. The platform is actively being upstreamed so there's a
   few things in flight, we've seen this happen before and sometimes
   it's hard to catch in time.

Besides that there is the usual mix of minor fixes.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: Replace uses of virt_to_phys with __pa_symbol

Alexandre Torgue (2):
      ARM: dts: stm32: Fix STMPE1600 binding on stm32429i-eval board
      ARM: dts: stm32: use right pinctrl compatible for stm32f469

Arnd Bergmann (1):
      ARM: defconfig: FRAMEBUFFER_CONSOLE can no longer be =m

Baruch Siach (1):
      arm64: dt marvell: Fix AP806 system controller size

Eugeniy Paltsev (1):
      ARC: reset: add missing DT binding documentation for HSDKv1 reset driver

Geert Uytterhoeven (1):
      reset: Restrict RESET_HSDK to ARC_SOC_HSDK or COMPILE_TEST

H. Nikolaus Schaller (1):
      ARM: OMAP2+: hsmmc: fix logic to call either omap_hsmmc_init or omap_hsmmc_late_init but not both

Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: Add basic cpu frequencies for RK3368"

Jerome Brunet (9):
      ARM64: dts: meson-gx: Use correct mmc clock source 0
      ARM64: dts: meson: remove cap-sd-highspeed from emmc nodes
      ARM64: dts: meson: add mmc clk gate pins
      ARM64: dts: meson-gxbb: nanopi-k2: add card regulator settle times
      ARM64: dts: meson-gxl: libretech-cc: add card regulator settle times
      ARM64: dts: meson-gxl: libretech-cc: enable high speed modes
      ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
      ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
      ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode

Keerthy (2):
      ARM: OMAP2+: dra7xx: Set OPT_CLKS_IN_RESET flag for gpio1
      ARM: dts: dra7: Set a default parent to mcasp3_ahclkx_mux

Linus Walleij (1):
      ARM: defconfig: update Gemini defconfig

Ludovic Desroches (2):
      ARM: dts: at91: sama5d27_som1_ek: update pinmux/pinconf for LEDs and USB
      ARM: dts: at91: sama5d27_som1_ek: fix typos

Nickey Yang (2):
      arm64: dts: rockchip: Correct MIPI DPHY PLL clock on rk3399
      arm64: dts: rockchip: add the grf clk for dw-mipi-dsi on rk3399

Nicolas Ferre (1):
      ARM: dts: at91: sama5d27_som1_ek: fix USB host vbus

Olof Johansson (8):
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'davinci-fixes-for-v4.14' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'reset-fixes-for-4.14' of git://git.pengutronix.de/git/pza/linux into fixes
      Merge tag 'mvebu-fixes-4.14-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'v4.14-rockchip-dts64fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'omap-for-v4.14/fixes-rc3' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'amlogic-dt64-3' of git://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'stm32-dt-fixes-for-v4.14' of git://git.kernel.org/.../atorgue/stm32 into fixes

Pavel Machek (1):
      ARM: dts: nokia n900: drop unneeded/undocumented parts of the dts

Russell King (1):
      MAINTAINERS: add Macchiatobin maintainers entry

Sekhar Nori (1):
      ARM: dts: da850-evm: add serial and ethernet aliases

Suniel Mahesh (1):
      ARM: dts: am33xx: Add spi alias to match SOC schematics

Thomas Meyer (1):
      ARC: reset: Only build on archs that have IOMEM

Vineet Gupta (1):
      ARC: reset: remove the misleading v1 suffix all over

Yogesh Siraswar (1):
      ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry

 .../devicetree/bindings/reset/snps,hsdk-reset.txt  |  28 ++
 MAINTAINERS                                        |  12 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   6 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |  19 +-
 arch/arm/boot/dts/da850-evm.dts                    |   7 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   2 +
 arch/arm/boot/dts/omap3-n900.dts                   |  11 -
 arch/arm/boot/dts/stm32429i-eval.dts               |   5 +-
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             | 343 +++++++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts              |   1 +
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi           |  95 ++++++
 arch/arm/boot/dts/stm32f429.dtsi                   | 297 ------------------
 arch/arm/boot/dts/stm32f469-disco.dts              |   1 +
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi           |  96 ++++++
 arch/arm/configs/gemini_defconfig                  |   3 +-
 arch/arm/configs/pxa_defconfig                     |   2 +-
 arch/arm/configs/viper_defconfig                   |   2 +-
 arch/arm/configs/zeus_defconfig                    |   2 +-
 arch/arm/mach-at91/pm.c                            |   4 +-
 arch/arm/mach-omap2/hsmmc.c                        |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  10 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |  19 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  12 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   9 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  13 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  10 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  39 ++-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |   7 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  13 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  10 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  10 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  39 ++-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   7 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |   1 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   4 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  72 +----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 drivers/reset/Kconfig                              |   9 +-
 drivers/reset/Makefile                             |   2 +-
 drivers/reset/{reset-hsdk-v1.c => reset-hsdk.c}    |  44 +--
 include/dt-bindings/reset/snps,hsdk-reset.h        |  17 +
 include/dt-bindings/reset/snps,hsdk-v1-reset.h     |  17 -
 44 files changed, 810 insertions(+), 503 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/snps,hsdk-reset.txt
 create mode 100644 arch/arm/boot/dts/stm32f4-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f429-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f469-pinctrl.dtsi
 rename drivers/reset/{reset-hsdk-v1.c => reset-hsdk.c} (72%)
 create mode 100644 include/dt-bindings/reset/snps,hsdk-reset.h
 delete mode 100644 include/dt-bindings/reset/snps,hsdk-v1-reset.h
