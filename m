From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 12 Nov 2015 15:07:35 +0100
Subject: [PATCH v2 2/5] arm: dts: add dm816x missing spi DT dma handles
Message-ID: <56449D27.9090603@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing SPI controller DMA handler in the dm816x DT
node, only properties for the two channels on four were present.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a7a34e4..eee636d 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -280,8 +280,11 @@
 			ti,spi-num-cs = <4>;
 			ti,hwmods = "mcspi1";
 			dmas = <&edma 16 &edma 17
-				&edma 18 &edma 19>;
-			dma-names = "tx0", "rx0", "tx1", "rx1";
+				&edma 18 &edma 19
+				&edma 20 &edma 21
+				&edma 22 &edma 23>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
 		};

 		mmc1: mmc at 48060000 {
-- 
1.9.1
