From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 23:47:05 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.13
Message-ID: <CAK8P3a0SvtmA1O-W6YsCiBC8+MUn2sA2Bntb7nsQwAiBOw5WvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missed the '[GIT PULL]' in the subject, sorry.

On Fri, Aug 4, 2017 at 11:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:
>
>   Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> tags/armsoc-fixes
>
> for you to fetch changes up to 41c454fa0e86e3d186abfe1598645ead667da4ac:
>
>   Merge tag 'davinci-fixes-for-v4.13' of
> git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci
> into fixes (2017-08-04 13:22:33 +0200)
>
> ----------------------------------------------------------------
> ARM: SoC fixes for 4.13
>
> This comes a bit later than I planned, and as a consequence is a larger
> than it should be.
>
> Most of the changes are devicetree fixes, across lots of platforms:
> Renesas, Samsung Exynos, Marvell EBU, TI OMAP, Rockchips, Amlogic Meson,
> Sigma Desings Tango, Allwinner SUNxi and TI Davinci.
>
> Also across many platforms, I applied an older series of simple randconfig
> build fixes. This includes making the CONFIG_MTD_XIP option compile again,
> which had been broken for many years and probably has not been missed, but
> it felt wrong to just remove it completely.
>
> The only other changes are:
>
>  - We enable HWSPINLOCK in defconfig to get some Qualcomm boards
>    to work out of the box.
>
>  - A few regression fixes for Texas Instruments OMAP2+.
>
>  - A boot regression fix for the Renesas regulator quirk.
>
>  - A suspend/resume fix for Uniphier SoCs, fixing the resume of the
>    system bus.
>
> ----------------------------------------------------------------
> Alexander Sverdlin (1):
>       ARM: ep93xx: normalize clk API
>
> Antoine Tenart (1):
>       arm64: dts: marvell: mark the cp110 crypto engine as dma coherent
>
> Arnd Bergmann (26):
>       Merge tag 'renesas-fixes-for-v4.13' of
> https://git.kernel.org/.../horms/renesas into fixes
>       Merge tag 'omap-for-v4.13/fixes-merge-window' of
> git://git.kernel.org/.../tmlind/linux-omap into fixes
>       Merge tag 'renesas-fixes2-for-v4.13' of
> https://git.kernel.org/.../horms/renesas into fixes
>       Merge tag 'mvebu-fixes-4.13-1' of
> git://git.infradead.org/linux-mvebu into fixes
>       ARM: davinci: don't mark vpif_input structures as 'const'
>       ARM: sa1100/pxa: fix MTD_XIP build
>       ARM: davinci: normalize clk API
>       ARM: sa1100: normalize clk API
>       ARM: w90x900: normalize clk API
>       ARM: rpc: rename RAM_SIZE macro
>       ARM: omap1/ams-delta: warn about failed regulator enable
>       ARM: ixp4xx: use normal prototype for {read,write}s{b,w,l}
>       ARM: sirf: mark sirfsoc_init_late as __maybe_unused
>       ARM: omap1: avoid unused variable warning
>       ARM: omap2: mark unused functions as __maybe_unused
>       ARM: mmp: mark usb_dma_mask as __maybe_unused
>       ARM: ep93xx: use ARM_PATCH_PHYS_VIRT correctly
>       ARM: ixp4xx: fix ioport_unmap definition
>       ARM: pxa: select both FB and FB_W100 for eseries
>       Merge tag 'v4.13-rockchip-dts32fixes-1' of
> git://git.kernel.org/.../mmind/linux-rockchip into fixes
>       Merge tag 'amlogic-fixes' of
> git://git.kernel.org/.../khilman/linux-amlogic into fixes
>       Merge tag 'mvebu-fixes-4.13-2' of
> git://git.infradead.org/linux-mvebu into fixes
>       Merge tag 'renesas-fixes3-for-v4.13' of
> https://git.kernel.org/.../horms/renesas into fixes
>       Merge tag 'qcom-arm64-defconfig-fixes-for-4.13-rc2' of
> git://git.kernel.org/.../agross/linux into fixes
>       Merge tag 'sunxi-fixes-for-4.13' of
> https://git.kernel.org/.../sunxi/linux into fixes
>       Merge tag 'davinci-fixes-for-v4.13' of
> git://git.kernel.org/.../nsekhar/linux-davinci into fixes
>
> Chen-Yu Tsai (1):
>       ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros
>
> Corentin Labbe (2):
>       ARM: dts: sunxi: h3/h5: Correct emac register size
>       arm64: allwinner: sun50i-a64: Correct emac register size
>
> Geert Uytterhoeven (2):
>       soc: zte: Restrict SOC_ZTE to ARCH_ZX or COMPILE_TEST
>       ARM: shmobile: rcar-gen2: Fix deadlock in regulator quirk
>
> Georgi Djakov (1):
>       arm64: defconfig: enable missing HWSPINLOCK
>
> Gregory CLEMENT (3):
>       ARM: mvebu: use __pa_symbol in the mv98dx3236 platform SMP code
>       ARM: dts: armada-38x: Fix irq type for pca955
>       ARM64: dts: marvell: armada-37xx: Fix the number of GPIO on south bridge
>
> Heiko Stuebner (2):
>       dt-bindings: gpu: drop wrong compatible from midgard binding example
>       ARM: dts: rockchip: fix mali gpu node on rk3288
>
> Jerome Brunet (2):
>       ARM64: dts: meson-gx: use specific compatible for the AO pwms
>       ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition
>
> Kevin Hilman (2):
>       ARM: dts: da850-evm: drop unused VPIF endpoints
>       ARM: dts: da850-lcdk: drop unused VPIF endpoints
>
> Krzysztof Kozlowski (1):
>       ARM: dts: exynos: Add clocks to audss block to fix silent hang
> on Exynos4412
>
> Kuninori Morimoto (1):
>       arm64: renesas: salvator-common: sound clock-frequency needs
> descending order
>
> Lokesh Vutla (1):
>       ARM: dts: dra71-evm: mdio: Fix impedance values
>
> Marc Gonzalez (1):
>       ARM: dts: tango4: Request RGMII RX and TX clock delays
>
> Masahiro Yamada (1):
>       bus: uniphier-system-bus: set up registers when resuming
>
> Mihail Grigorov (1):
>       ARM: dts: dm816x: Correct the state of the write protect pin
>
> Thomas Petazzoni (1):
>       arm64: dts: marvell: use ICU for the CP110 slave RTC
>
> Tom Rini (1):
>       ARM: dts: dm816x: Correct NAND support nodes
>
> Tony Lindgren (2):
>       ARM: OMAP2+: Fix omap3 prm shared irq
>       ARM: OMAP4: Fix legacy code clean-up regression
>
> Vladimir Barinov (1):
>       arm64: dts: renesas: ulcb: sound clock-frequency needs descending order
>
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt   |   2 +-
>  arch/arm/Kconfig                                   |   2 +-
>  arch/arm/boot/dts/armada-388-gp.dts                |   4 +-
>  arch/arm/boot/dts/da850-evm.dts                    |  21 -----
>  arch/arm/boot/dts/da850-lcdk.dts                   |   7 --
>  arch/arm/boot/dts/dm8168-evm.dts                   |  34 ++++++-
>  arch/arm/boot/dts/dm816x.dtsi                      |   2 +-
>  arch/arm/boot/dts/dra71-evm.dts                    |   4 +-
>  arch/arm/boot/dts/exynos4.dtsi                     |   3 +
>  arch/arm/boot/dts/rk3288.dtsi                      |   4 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi                  |  16 ++--
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   2 +-
>  arch/arm/boot/dts/tango4-vantage-1172.dts          |   2 +-
>  arch/arm/mach-davinci/board-da850-evm.c            |   4 +-
>  arch/arm/mach-davinci/clock.c                      |   9 ++
>  arch/arm/mach-ep93xx/clock.c                       |  20 ++++
>  arch/arm/mach-ixp4xx/include/mach/io.h             |  34 +++++--
>  arch/arm/mach-mmp/devices.c                        |   2 +-
>  arch/arm/mach-mvebu/platsmp.c                      |   2 +-
>  arch/arm/mach-omap1/board-ams-delta.c              |  12 ++-
>  arch/arm/mach-omap1/board-osk.c                    |   4 -
>  arch/arm/mach-omap2/board-generic.c                |   2 +-
>  arch/arm/mach-omap2/io.c                           |   2 +-
>  arch/arm/mach-omap2/pm34xx.c                       |   1 -
>  arch/arm/mach-omap2/prm3xxx.c                      |   7 +-
>  arch/arm/mach-omap2/prm44xx.c                      |  55 +++++++++++
>  arch/arm/mach-prima2/common.c                      |   2 +-
>  arch/arm/mach-pxa/Kconfig                          |   1 +
>  arch/arm/mach-pxa/include/mach/mtd-xip.h           |  10 +-
>  arch/arm/mach-rpc/include/mach/hardware.h          |   4 +-
>  arch/arm/mach-sa1100/clock.c                       |  25 +++++
>  arch/arm/mach-sa1100/include/mach/mtd-xip.h        |   4 +-
>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |   6 +-
>  arch/arm/mach-w90x900/clock.c                      |  29 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   2 +-
>  .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   4 +-
>  .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 103 ++++++++++++++++++---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   2 +-
>  .../boot/dts/marvell/armada-cp110-master.dtsi      |   1 +
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   3 +-
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   2 +-
>  arch/arm64/boot/dts/renesas/ulcb.dtsi              |   2 +-
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/bus/uniphier-system-bus.c                  |  14 +++
>  drivers/soc/zte/Kconfig                            |   1 +
>  46 files changed, 372 insertions(+), 103 deletions(-)
