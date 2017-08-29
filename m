From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Tue, 29 Aug 2017 22:26:50 +0200
Subject: [RESEND PATCH 0/2] Enable SPI on A64/Pine64
Message-ID: <20170829202652.5476-1-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SPI controller is compatible to the H3/H5 controller, i.e. same
registers and same queue depth.

The Pine64 exposes both controllers on the PI-2 and Euler connectors.

Tested/verified with logic analyser and spidev_test using MOSI/MISO loopback.

Note: spi0 on the A64 may conflict with the eMMC controller, as the MISO pin is
also used for the HS400 eMMC data strobe. This is only a concern if the board
uses eMMC (does not apply to the Pine64) *and* is using HS400 mode. The same
pin conflict exists for the H5.

Stefan Br?ns (2):
  arm64: allwinner: a64: add SPI nodes
  arm64: allwinner: pine64: Enable spi0/spi1

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  8 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 40 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.14.1
