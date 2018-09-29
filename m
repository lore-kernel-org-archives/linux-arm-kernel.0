From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 16:07:29 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.20
Message-ID: <20180929140729.gnu7i4q6jvv3dblm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are the usual H3/H5 changes for the next merge window spread
across arm and arm64.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.20

for you to fetch changes up to 6eeb4180d4b9887b6bc8bbe0a22c1ce3634417f0:

  ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees (2018-09-29 15:58:38 +0200)

----------------------------------------------------------------
Allwinner H3 and H5 DT additions for 4.20

This is our usual H3/H5 pull request

The most notable changes are:
  - the video decoding / encoding unit is finally enabled on the H3
  - Mali support for the H5
  - New boards: BananaPi M2+ v1.2, Orange Pi Zero Plus 2 H3 support

----------------------------------------------------------------
Chen-Yu Tsai (5):
      arm64: dts: allwinner: h5: Add device node for Mali-450 GPU
      ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external RGMII Ethernet PHY
      ARM: dts: sun8i: h3: Split out non-SoC-specific parts of Bananapi M2 Plus
      arm64: dts: allwinner: h5: Add device tree for Bananapi M2 Plus H5
      ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees

Diego Rondini (1):
      ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support

Emmanuel Vadot (1):
      nvmem: sunxi-sid: add support for H5's SID controller

Paul Kocialkowski (1):
      ARM: dts: sun8i-h3: Add Video Engine and reserved memory nodes

Philipp Rossak (1):
      ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block

 .../bindings/nvmem/allwinner,sunxi-sid.txt         |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 .../boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts    |  13 ++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 190 +----------------
 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 140 +++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  25 +++
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi |  31 +++
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi      | 231 +++++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   2 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts  |  11 +
 .../dts/allwinner/sun50i-h5-bananapi-m2-plus.dts   |  11 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |  43 ++++
 13 files changed, 513 insertions(+), 189 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
 create mode 100644 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/f1fe4d98/attachment.sig>
