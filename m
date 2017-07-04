From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:17:50 +0200
Subject: [GIT PULL 0/7] ARM: SoC specific changes for 4.13
Message-ID: <CAK8P3a34OjrwzK5saNz=nq2qkm1kqJD8rb6Qz67R+Lt6jKa=7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the full set of patches for arm-soc for this merge window.
We have 764 non-merge changesets from 81 contributors this time,
in 101 pull requests and 20 separate patches.

The top contributors this time are

     54 Andreas F?rber
     29 Chen-Yu Tsai
     22 Geert Uytterhoeven
     21 Martin Blumenstingl
     18 Fabio Estevam
     17 Krzysztof Kozlowski
     17 Corentin Labbe
     16 Neil Armstrong
     16 Icenowy Zheng
     14 Tony Lindgren
     14 Simon Horman
     14 Markus Elfring
     13 Ralph Sennhauser
     12 Sean Wang
     12 Linus Walleij
     12 Gregory CLEMENT
     11 Suman Anna
     11 Antoine Tenart
     11 Alexandre Belloni
     10 Kuninori Morimoto

Andreas F?rber adds three new SoC platforms (Action Semi on 32-bit
and 64-bit as well as Realtek RTL1295), the other contributors are more
or less the same as always, and the most active platforms remain
Allwinner, Renesas, Amlogic, NXP/Freescale, OMAP, AT91 and
Samsung, but there are also a lot patches for the smaller ones.

Overall, the devicetree changes dominate the overall contents, but
in particular the ARM64 device trees are growing faster these days,
with more new boards getting added there. Split out into three
separate chunks, these are the overall size stats:

a) ARM32 device tree files:
  100% arch/arm64/boot/dts/
 316 patches, 404 files changed, 11156 insertions(+), 4068 deletions(-)

b) ARM64 device tree files:
   1.5% arch/arm64/boot/dts/actions/
   8.9% arch/arm64/boot/dts/allwinner/
   6.1% arch/arm64/boot/dts/amlogic/
   0.7% arch/arm64/boot/dts/arm/
  12.0% arch/arm64/boot/dts/broadcom/stingray/
   0.2% arch/arm64/boot/dts/broadcom/
   8.6% arch/arm64/boot/dts/freescale/
  13.4% arch/arm64/boot/dts/hisilicon/
   6.8% arch/arm64/boot/dts/marvell/
   3.9% arch/arm64/boot/dts/mediatek/
   0.1% arch/arm64/boot/dts/nvidia/
   1.2% arch/arm64/boot/dts/qcom/
   1.2% arch/arm64/boot/dts/realtek/
  22.5% arch/arm64/boot/dts/renesas/
   8.3% arch/arm64/boot/dts/rockchip/
   3.8% arch/arm64/boot/dts/socionext/
 217 patches, 152 files changed, 11045 insertions(+), 2362 deletions(-)

c) Everything else:
   0.7% Documentation/arm/Atmel/
  10.7% arch/arm/configs/
   3.7% arch/arm/mach-actions/
   5.2% arch/arm/mach-at91/
   0.0% arch/arm/mach-bcm/
   0.1% arch/arm/mach-davinci/include/mach/
   0.7% arch/arm/mach-davinci/
   0.3% arch/arm/mach-imx/
   0.0% arch/arm/mach-meson/
   0.2% arch/arm/mach-omap1/
  30.0% arch/arm/mach-omap2/
   0.0% arch/arm/mach-prima2/
   0.0% arch/arm/mach-pxa/include/mach/
   1.5% arch/arm/mach-pxa/
   0.0% arch/arm/mach-rockchip/
   0.0% arch/arm/mach-s3c64xx/
   0.3% arch/arm/mach-shmobile/
   0.0% arch/arm/mach-stm32/
   1.0% arch/arm/
   0.3% arch/arm64/configs/
   0.3% arch/arm64/
   0.1% drivers/base/power/
   2.3% drivers/bus/
   0.6% drivers/clk/meson/
   2.9% drivers/clocksource/
   0.6% drivers/cpufreq/
   0.3% drivers/firmware/tegra/
   0.9% drivers/firmware/
   0.2% drivers/memory/
   0.1% drivers/reset/sti/
   8.2% drivers/reset/
   4.3% drivers/soc/actions/
   1.2% drivers/soc/atmel/
   0.0% drivers/soc/bcm/
   0.0% drivers/soc/imx/
   2.9% drivers/soc/mediatek/
   0.2% drivers/soc/qcom/
   2.9% drivers/soc/renesas/
   5.8% drivers/soc/tegra/
   0.1% drivers/soc/
   0.5% include/linux/platform_data/
   0.1% include/linux/soc/actions/
   0.1% include/linux/soc/renesas/
   0.1% include/linux/
   8.0% include/soc/tegra/
178 patches,  217 files changed, 3700 insertions(+), 1974 deletions(-)

The parts sticking out here are a defconfig cleanup by Krzysztof Koz?owski,
omap2 code cleanup, reset subsystem changes and a new power
management driver for tegra.

     Arnd
