From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Dec 2016 23:55:38 +0100
Subject: [GIT PULL 0/7] ARM: SoC changes for v4.10
Message-ID: <2664636.Hf0nvRznEK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the arm-soc changes for this merge window. There is not much
noteworthy this time, with a rather average size of the changes, but
a still increasing portion of that being for device trees.

The main changes outside of the boot/dts directories this time are
in mach-omap2, and this is mostly for removing dead code after the
platform become DT-only in the last cycle.

We've had a couple of inter-tree dependencies that were not handled
perfectly, and you will find some simple merge conflicts again as the
other trees got merged first, but I think we managed to resolve
all the dependencies in a way that does not break bisection.

Some statistics for our changes:
    854 non-merge changesets total
    602 changesets for next/dt and next/dt64 alone
    131 branches pulled
    187 individual contributors
    791 files changed
  44336 insertions(+)
  19229 deletions(-)

Top contributors by number of non-merge changesets:
     45 Neil Armstrong <narmstrong@baylibre.com>
     30 Geert Uytterhoeven <geert+renesas@glider.be>
     26 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
     24 Gregory CLEMENT <gregory.clement@free-electrons.com>
     18 Tony Lindgren <tony@atomide.com>
     18 Thierry Reding <treding@nvidia.com>
     18 Patrice Chotard <patrice.chotard@st.com>
     18 Maxime Ripard <maxime.ripard@free-electrons.com>
     18 Krzysztof Kozlowski <krzk@kernel.org>
     16 Simon Horman <horms+renesas@verge.net.au>
     16 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
     14 Masahiro Yamada <yamada.masahiro@socionext.com>
     13 Vladimir Barinov <vladimir.barinov@cogentembedded.com>
     13 Milo Kim <woogyom.kim@gmail.com>
     13 Chen-Yu Tsai <wens@csie.org>
     12 Robert Jarzmik <robert.jarzmik@free.fr>
     12 Peter Griffin <peter.griffin@linaro.org>
     12 David Lechner <david@lechnology.com>
     11 Javier Martinez Canillas <javier@osg.samsung.com>
     10 Linus Walleij <linus.walleij@linaro.org>

Dirstat (=0.1)
   0.1% Documentation/devicetree/bindings/arm/keystone/
   0.4% Documentation/devicetree/bindings/arm/
   0.3% Documentation/devicetree/bindings/bus/
   0.2% Documentation/devicetree/bindings/firmware/
   0.1% Documentation/devicetree/bindings/mailbox/
   0.1% Documentation/devicetree/bindings/reset/
   0.3% Documentation/devicetree/bindings/
  38.4% arch/arm/boot/dts/
   0.2% arch/arm/configs/
   1.3% arch/arm/mach-davinci/
   0.7% arch/arm/mach-imx/
   0.2% arch/arm/mach-lpc32xx/include/mach/
   0.1% arch/arm/mach-omap1/
  15.5% arch/arm/mach-omap2/
   0.5% arch/arm/mach-orion5x/
   0.3% arch/arm/mach-oxnas/
   0.4% arch/arm/mach-pxa/
   0.2% arch/arm/mach-shmobile/
   0.2% arch/arm/plat-omap/
   0.3% arch/arm/
   0.6% arch/arm64/boot/dts/allwinner/
   4.9% arch/arm64/boot/dts/amlogic/
   0.1% arch/arm64/boot/dts/arm/
   0.1% arch/arm64/boot/dts/broadcom/
   5.5% arch/arm64/boot/dts/exynos/
   1.6% arch/arm64/boot/dts/freescale/
   1.3% arch/arm64/boot/dts/hisilicon/
   0.1% arch/arm64/boot/dts/marvell/
   0.6% arch/arm64/boot/dts/nvidia/
   1.3% arch/arm64/boot/dts/qcom/
   1.1% arch/arm64/boot/dts/renesas/
   0.6% arch/arm64/boot/dts/rockchip/
   0.2% arch/arm64/boot/dts/socionext/
   0.1% arch/arm64/
   0.8% drivers/bus/
   2.3% drivers/firmware/tegra/
   5.8% drivers/firmware/
   0.7% drivers/mailbox/
   0.2% drivers/memory/
   0.5% drivers/reset/sti/
   0.1% drivers/reset/tegra/
   0.2% drivers/reset/
   0.4% drivers/soc/mediatek/
   0.5% drivers/soc/renesas/
   0.1% drivers/soc/rockchip/
   0.8% drivers/soc/tegra/
   0.2% drivers/
   2.4% include/dt-bindings/clock/
   0.2% include/dt-bindings/power/
   0.6% include/dt-bindings/reset/
   0.1% include/dt-bindings/
   0.6% include/linux/soc/ti/
   3.0% include/soc/tegra/
   0.1% include/

	Arnd
