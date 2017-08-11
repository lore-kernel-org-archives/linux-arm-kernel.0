From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sat, 12 Aug 2017 00:28:11 +0200
Subject: [PATCH 0/2] Enable SPI on A64/Pine64
Message-ID: <30760d6e16f3406688fadeb7d8e0b287@rwthex-w2-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SPI controller is compatible to the H3/H5 controller, i.e. same
registers and same queue depth.

The Pine64 exposes both controllers on the PI-2 and Euler connectors.

Tested/verified with logic analyser and spidev_test using MOSI/MISO loopback.

Stefan Br?ns (2):
  arm64: allwinner: a64: add SPI nodes
  arm64: allwinner: pine64: Enable spi0/spi1

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  8 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 40 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.13.3
