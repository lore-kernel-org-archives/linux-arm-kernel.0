From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:07:24 +0200
Subject: [GIT PULL 0/7] ARM: SoC changes for 4.7
Message-ID: <8749147.ztcb6kVhye@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

These are the first seven pull requests for arm-soc this time, there is
one small follow-up coming once the dependencies for that have landed
in your tree.

Things remain relatively calm for us. We merged 122 pull requests with
822 patches, plus 35 individual patches, which is less than what we used
to have. We are shifting even more towards changing only dts files,
for the most part adding new functionality on existing boards, and adding
new machines, as shown clearly by the dirstat:

   3.4% Documentation/devicetree/bindings/
  56.3% arch/arm/boot/dts/
   0.7% arch/arm/configs/
   0.0% arch/arm/mach-aspeed/
   0.2% arch/arm/mach-at91/
   0.0% arch/arm/mach-bcm/
   0.5% arch/arm/mach-davinci/
   0.0% arch/arm/mach-dove/
   0.1% arch/arm/mach-exynos/
   0.0% arch/arm/mach-imx/
   0.1% arch/arm/mach-integrator/
   0.1% arch/arm/mach-lpc32xx/
   0.0% arch/arm/mach-mediatek/
   0.0% arch/arm/mach-mv78xx0/
   1.3% arch/arm/mach-omap2/
   0.0% arch/arm/mach-orion5x/
   0.0% arch/arm/mach-oxnas/
   0.0% arch/arm/mach-realview/
   0.0% arch/arm/mach-rockchip/
   0.3% arch/arm/mach-shmobile/
   0.0% arch/arm/mach-sti/
   0.0% arch/arm/mach-tegra/
   0.0% arch/arm/mach-uniphier/
   0.0% arch/arm/mach-versatile/
   0.0% arch/arm/mach-vexpress/
   0.0% arch/arm/plat-samsung/
   0.9% arch/arm/
  13.1% arch/arm64/boot/dts/
   0.0% arch/arm64/configs/
   0.0% arch/arm64/
   0.0% drivers/bus/
   0.9% drivers/clk/
   0.0% drivers/firmware/
   0.0% drivers/gpu/drm/tegra/
   0.0% drivers/gpu/drm/vc4/
   0.0% drivers/irqchip/
   0.4% drivers/memory/samsung/
   0.0% drivers/memory/
   0.4% drivers/mtd/maps/
   0.0% drivers/of/
   0.3% drivers/pci/host/
   9.2% drivers/phy/tegra/
   0.1% drivers/phy/
   0.0% drivers/pinctrl/tegra/
   0.6% drivers/reset/
   0.1% drivers/soc/brcmstb/
   1.0% drivers/soc/mediatek/
   0.4% drivers/soc/qcom/
   1.2% drivers/soc/renesas/
   0.4% drivers/soc/rockchip/
   0.7% drivers/soc/tegra/
 730 files changed, 47909 insertions(+), 7916 deletions(-)

My feeling is that the number of dts changes remain constant, but
everything else gets less every time, and that's good.

One part that sticks out this time in the dirstat this time is the
NVIDIA rework for the USB PHY, which had complex interdependencies so
we are merging all the subsystem specific change through arm-soc.

I currently don't see any conflicts against other trees, or between
our branches.

The most active individual developers (15 patches or more) out of the 165 people
that contributed this time were:

     51 Geert Uytterhoeven
     42 Simon Horman
     23 Heiko Stuebner
     22 Hans de Goede
     21 Jon Hunter
     21 Chanwoo Choi
     20 Thierry Reding
     17 Vladimir Zapolskiy
     17 Linus Walleij
     17 Krzysztof Kozlowski
     16 Lee Jones
     15 Srinivas Kandagatla
     15 Roger Quadros
     15 Fabio Estevam

	Arnd
