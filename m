From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Aug 2018 16:09:23 +0800
Subject: [PATCH 0/3] arm64: dts: allwinner: h5: Add device tree for Bananapi
 M2 Plus H5
Message-ID: <20180830080926.15027-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Allwinner's H5 SoC is pin compatible with the H3 SoC. As such, some
vendors produce H3 and H5 variants for the same device. Such is the
case with Libre Computer's ALL-H3-CC, and the Bananapi M2 Plus.

This series follows that of the ALL-H3-CC, splitting out a common
board dtsi, and then two SoC-specific dts files that include the
SoC level and common board dtsi's, as well as putting in the board
name. The first patch is a minor fix that I think should be done
before the migration.

Please have a look.

Also, on a related matter, Bananapi recently released revision v1.2
of the M2 Plus. The original commercially available version was v1.1.
v1.2 adds a GPIO control that can change the CPU cores' supply voltage
between 1.1V and 1.3V. Do we want two extra dts files for this? Put
them in the existing dts files regardless? Or let people handle this
via overlays?

Thanks
ChenYu


Chen-Yu Tsai (3):
  ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external RGMII
    Ethernet PHY
  ARM: dts: sun8i: h3: Split out non-SoC-specific parts of Bananapi M2
    Plus
  arm64: dts: allwinner: h5: Add device tree for Bananapi M2 Plus H5

 .../boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 190 +-----------------
 ...2-plus.dts => sunxi-bananapi-m2-plus.dtsi} |   7 +-
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h5-bananapi-m2-plus.dts  |  11 +
 4 files changed, 15 insertions(+), 194 deletions(-)
 copy arch/arm/boot/dts/{sun8i-h3-bananapi-m2-plus.dts => sunxi-bananapi-m2-plus.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts

-- 
2.18.0
