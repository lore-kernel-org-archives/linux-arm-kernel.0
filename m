From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Nov 2015 11:38:52 -0800
Subject: [PATCH 1/4] ARM: shmobile: bockw: Move SPI FLASH partition to subnode
In-Reply-To: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
References: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448048335-23927-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support partitions
in a special 'partitions' subnode"), having partitions as direct subnodes
of an mtd device is discouraged. Hence move the SPI FLASH partition to a
"partitions" subnode.

Based on similar work for the koelsch board by Geert Uytterhoeven.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 90543b12d7e2..bf77ff569ca1 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -184,16 +184,19 @@
 	status = "okay";
 
 	flash: flash at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl008k", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
 
-		partition at 0 {
-			label = "data(spi)";
-			reg = <0x00000000 0x00100000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "data(spi)";
+				reg = <0x00000000 0x00100000>;
+			};
 		};
 	};
 };
-- 
2.1.4
