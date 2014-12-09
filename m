From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 22:20:34 +0100
Subject: [GIT PULL 0/9] ARM: SoC changes for 3.19
Message-ID: <4491193.a6KEQb1tZH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This is the 3.19 set of branches for ARM SoC related changes. As usual,
about half the additions are for device tree files, both counting the
number of patches and number of lines. The other changes are all dwarfed
by the removal of the remaining legacy machine support in the Atmel at91
platform, now that this platform has sufficient DT support.

Aside from this one-time peak for at91, the most active platforms remain
shmobile, omap, sunxi and exynos.

We are also adding a record number of 12 new arm32 SoC types and 2
arm64 SoC types in this merge window, with at least four more that
almost made it in but were a little late.

This is also the first time we do not have 'boards' branch that tracks
changes to board specific files any more: We now support 527 individual
machine types with device tree and have 258 old-style board files, but
the latter are rarely updated these days.

Total number of changesets (including merges): 1120
Total number of merge changesets: 147
Total number of contributors: 170

Overall diffstat:
 867 files changed, 37747 insertions(+), 36520 deletions(-)

Dirstat:
$ git diff --dirstat=0.2 v3.18..for-next
   0.4% Documentation/devicetree/bindings/arm/
   0.5% Documentation/devicetree/bindings/
  31.7% arch/arm/boot/dts/
   1.4% arch/arm/configs/
   0.2% arch/arm/include/
   0.8% arch/arm/kernel/
  30.4% arch/arm/mach-at91/
   0.5% arch/arm/mach-bcm/
   0.4% arch/arm/mach-davinci/
   3.9% arch/arm/mach-exynos/
   0.6% arch/arm/mach-imx/
   0.6% arch/arm/mach-integrator/
   1.1% arch/arm/mach-mvebu/
   5.0% arch/arm/mach-omap2/
   0.3% arch/arm/mach-pxa/
   0.2% arch/arm/mach-rockchip/
   2.9% arch/arm/mach-shmobile/
   1.0% arch/arm/mach-vexpress/
   0.2% arch/arm/mm/
   1.9% arch/arm/
   0.3% arch/arm64/boot/dts/amd/
   0.5% arch/arm64/boot/dts/arm/
   1.3% drivers/bus/
   0.3% drivers/clk/
   0.3% drivers/clocksource/
   2.5% drivers/dma/
   2.5% drivers/iommu/
   2.8% drivers/memory/tegra/
   1.1% drivers/memory/
   0.3% drivers/reset/sti/
   0.2% drivers/rtc/
   0.2% drivers/soc/versatile/
   0.6% drivers/
   0.4% include/dt-bindings/
   0.6% include/linux/

Top 20 contributors by patch count (no merges):
$ git log --format=%an --no-merges v3.18..for-next  | sort | uniq -c  |sort -nr | head -n 20
     56 Geert Uytterhoeven
     48 Maxime Ripard
     31 Tero Kristo
     29 Nicolas Ferre
     28 Chen-Yu Tsai
     26 Linus Walleij
     24 Thomas Petazzoni
     24 Kuninori Morimoto
     24 Hans de Goede
     22 Peter Griffin
     20 Tony Lindgren
     20 Laurent Pinchart
     19 Sebastian Hesselbarth
     18 Roger Quadros
     15 Arnaud Ebalard
     14 Simon Horman
     13 Arnd Bergmann
     12 Thierry Reding
     12 Dmitry Lifshitz
     11 Zhangfei Gao
