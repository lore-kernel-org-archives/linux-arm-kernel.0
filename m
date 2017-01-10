From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 10 Jan 2017 01:22:30 +0000
Subject: [PATCH 0/3] arm64: dts: A64 board MMC support
Message-ID: <1484011353-21480-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches here go on top of Maxime's latest A64 MMC series and
enable the MMC controllers on the boards using the A64 SoC.
As the BananaPi-M64 DT now looks different, lets adds support for
that board as well, with one major difference to the Pine64 being the eMMC
chip.

I could't find commit f9ca9b952ee1 Maxime mentioned in his cover letter,
so I applied his patches on top of sunxi/for-next and cherry-picked
b4b8664d29 to fix the arm64 build.

Cheers,
Andre.

Andre Przywara (3):
  arm64: dts: Pine64: add MMC support
  arm64: dts: sun50i: add UART1 pin nodes
  arm64: dts: add BananaPi-M64 support

 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 120 +++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  20 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  10 ++
 4 files changed, 151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts

-- 
2.8.2
