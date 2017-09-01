From: olof@lixom.net (Olof Johansson)
Date: Fri, 1 Sep 2017 16:54:55 -0700
Subject: [GIT PULL] ARM: SoC fixes for 4.13
Message-ID: <20170901235455.GA22602@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Just a few final fixes for 4.13. See below for description. Please merge.


Thanks,

-Olof


The following changes since commit 93a4c8355e0e448d83f31801b4c72f66e4360975:

  ARM: dts: exynos: add needs-hpd for Odroid-XU3/4 (2017-08-23 21:43:29 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes

for you to fetch changes up to 6f71a925761e7843965a704eb6682ea337abb4a5:

  Merge tag 'mvebu-fixes-4.13-3' of git://git.infradead.org/linux-mvebu into fixes (2017-09-01 16:37:02 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.13

A couple of late-arriving fixes before final 4.13:

 - A few reverts of DT bindings on Allwinner for their ethernet
   driver. Discussion didn't converge, and since bindings are considered
   ABI it makes sense to revert instead of having to support two bindings
   long-term.
 - A fix to enumerate GPIOs properly on Marvell Armada AP806

----------------------------------------------------------------
Maxime Ripard (3):
      dt-bindings: net: Revert sun8i dwmac binding
      arm64: dts: allwinner: Revert EMAC changes
      arm: dts: sunxi: Revert EMAC changes

Olof Johansson (2):
      Merge tag 'sunxi-fixes-for-4.13-3' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'mvebu-fixes-4.13-3' of git://git.infradead.org/linux-mvebu into fixes

Thomas Petazzoni (1):
      arm64: dts: marvell: fix number of GPIOs in Armada AP806 description

 .../devicetree/bindings/net/dwmac-sun8i.txt        | 84 ----------------------
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  9 ---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 19 -----
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |  7 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  8 ---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  8 ---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |  5 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  8 ---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       | 22 ------
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     | 16 -----
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 26 -------
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 16 -----
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 15 ----
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 17 -----
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 16 -----
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 20 ------
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 17 -----
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 17 -----
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 17 -----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  4 +-
 20 files changed, 2 insertions(+), 349 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
