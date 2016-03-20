From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:21:40 +0100
Subject: [GIT PULL 0/8] ARM: SoC changes for 4.6
Message-ID: <10465240.PKeEEAAbCF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the arm-soc changes changes for 4.6. Nothing unusual this time, but the
previous trends continue:

* Fewer changes outside of devicetree files as most of the active platforms have
  very little left in terms of non-driver source code. Overall this mean a total
  of 786 non-merge changesets, out of which 513 were for DT.

* The non-DT changes tend to be fairly boring, the only ones sticking out
  size-wise (exynos and lpc32xx) are actually for files that are getting
  removed from arch/arm/.

* Changes to device tree files are increasing slowly, mainly as we are
   adding new SoC platforms and board files at an increasing rate

* Most of the changes are for 32-bit platforms, but 64-bit platforms
  are growing more quickly, now around 20% of the DT changes are for
  64-bit machines

* While the total number of changes goes down, the number of pull requests
  we merge is increasing over time (101 for 4.6, plus 76 standalone patches)
  because we get more platforms that each have their own sub-maintainers.

* 13 new SoC platforms got added this time, a rather high number:
  artpec6, keystone-k2g, mt7623, a83t, imx6qp, alpine-v2, armada-37xx,
  armada-7xxx/8xxx, meson-gxbb, msm8996, uniphier-ph1, juno-r2 and vulcan.
  Most are new SoCs that are related to SoC families, but some are 
  brandnew.

For overall statistics, here is the dirstat:

   1.0% Documentation/devicetree/bindings/arm/marvell/
   1.1% Documentation/devicetree/bindings/arm/
  53.2% arch/arm/boot/dts/
   0.5% arch/arm/configs/
   0.1% arch/arm/include/
   0.2% arch/arm/mach-artpec/
   0.2% arch/arm/mach-at91/
   0.6% arch/arm/mach-davinci/
   8.0% arch/arm/mach-exynos/
   1.5% arch/arm/mach-imx/
   4.5% arch/arm/mach-lpc32xx/
   0.1% arch/arm/mach-omap1/
   1.5% arch/arm/mach-omap2/
   0.3% arch/arm/mach-pxa/
   0.2% arch/arm/mach-s3c64xx/
   0.3% arch/arm/mach-shmobile/
   0.1% arch/arm/mach-uniphier/
   0.1% arch/arm/plat-versatile/
   2.1% arch/arm/
  12.1% arch/arm64/boot/dts/
   4.6% drivers/clk/at91/
   1.4% drivers/clk/imx/
   3.2% drivers/soc/samsung/
   1.4% drivers/
   3.3% include/dt-bindings/pinctrl/
   2.2% include/linux/soc/samsung/

We had 171 contributors this time, a fairly typical number. The ones with the 10
or more patches are

     46 Geert Uytterhoeven
     44 Simon Horman
     30 Arnd Bergmann
     27 Srinivas Kandagatla
     23 Lothar Wa?mann
     21 Masahiro Yamada
     20 Chen-Yu Tsai
     14 Stefan Agner
     14 Pankaj Dubey
     13 Sudeep Holla
     13 Philipp Zabel
     13 Linus Walleij
     12 Vladimir Zapolskiy
     12 Thomas Petazzoni
     12 Stephen Boyd
     12 Caesar Wang
     11 Roger Quadros
     11 Laurent Pinchart
     11 Gregory CLEMENT
     11 Alexandre Belloni
     10 Tony Lindgren
     10 Suravee Suthikulpanit
     10 Maxime Coquelin

And here is a list of all git trees we pulled from, along with the total
number of changesets we got from them.

  143 git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas
  100 git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux
   90 git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap
   65 git://git.infradead.org/linux-mvebu
   49 git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux
   44 http://github.com/Broadcom/stblinux
   43 git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip
   25 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux
   22 git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32
   19 git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
   17 https://github.com/mbgg/linux-mediatek
   17 git://git.pengutronix.de/git/pza/linux
   17 git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux
   16 https://github.com/rjarzmik/linux
   16 git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator
   11 https://github.com/AppliedMicro/xgene-next
   11 git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci
   10 https://github.com/Xilinx/linux-xlnx
    8 https://github.com/carlocaione/linux-meson
    8 git://github.com/hisilicon/linux-hisi
    7 git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91
    4 git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone
    3 https://github.com/rogerq/linux
    2 git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux

	Arnd
