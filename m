From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 24 Apr 2018 11:19:34 +0200
Subject: [PATCH 0/2] ARM64: allwinner: Add support for Libre Computer Board
 ALL-H3-CC H5 ver.
Message-ID: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
Pi B+ form factor single board computer based on the Allwinner H2+, H3, or H5
SoCs with the same PCB.
The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
and connectors are in the exact same position as on the Raspberry Pi B+.

This patchset enables the H5 variant by moving the H3 board definition to a
common dtsi then include this common dtsi in the H5 dts variant then declares
the correct compatible and model of the H5 variant.

Neil Armstrong (2):
  ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board definition to
    common dtsi
  ARM64: dts: allwinner: Add dts file for Libre Computer Board ALL-H3-CC
    H5 ver.

 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 209 +-------------------
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 211 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |  14 ++
 4 files changed, 228 insertions(+), 207 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

-- 
2.7.4
