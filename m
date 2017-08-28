From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Aug 2017 11:26:51 +0200
Subject: [GIT PULL] Allwinner fixes for 4.13, take 3
Message-ID: <20170828092651.xwrz6toedrmht5nh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a bunch of patches essentially reverting the EMAC bindings
additions. Indeed, it was discovered after the release of 4.13-rc1
that we overlooked some issues while reviewing the driver, and we
couldn't find a proper solution since then.

Since the binding is as such not stable yet, we can't allow it to
reach a stable release.

Maxime

The following changes since commit d86e63e1f0b7868c55c8d4a54854b85e2bac690b:

  arm64: allwinner: h5: fix pinctrl IRQs (2017-08-14 14:18:21 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.13-3

for you to fetch changes up to fe45174b72aead678da581bab9e9a37c9b26a070:

  arm: dts: sunxi: Revert EMAC changes (2017-08-28 11:11:24 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.13, take 3

This is a revert of the EMAC bindings. The discussion has not settled down
yet on a proper representation of the PHY, and therefore we cannot commit
to a binding yet

----------------------------------------------------------------
Maxime Ripard (3):
      dt-bindings: net: Revert sun8i dwmac binding
      arm64: dts: allwinner: Revert EMAC changes
      arm: dts: sunxi: Revert EMAC changes

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
 19 files changed, 347 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/7fab7f04/attachment-0001.sig>
