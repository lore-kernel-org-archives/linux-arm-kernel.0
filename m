From: t.remmet@phytec.de (Teresa Remmet)
Date: Mon, 9 Jan 2017 09:37:30 +0100
Subject: [PATCH] ARM: dts: am335x-phycore-som: Remove partition tables
Message-ID: <1483951050-46588-1-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the bootloader passes the NAND and the SPI flash partition tables
there is no need to keep them in the kernel device tree.
Removed them.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 58 -------------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 25f5449..14533ff 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -211,43 +211,6 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-
-		partition at 0 {
-			label = "xload";
-			reg = <0x0 0x20000>;
-		};
-		partition at 1 {
-			label = "xload_backup1";
-			reg = <0x20000 0x20000>;
-		};
-		partition at 2 {
-			label = "xload_backup2";
-			reg = <0x40000 0x20000>;
-		};
-		partition at 3 {
-			label = "xload_backup3";
-			reg = <0x60000 0x20000>;
-		};
-		partition at 4 {
-			label = "barebox";
-			reg = <0x80000 0x80000>;
-		};
-		partition at 5 {
-			label = "bareboxenv";
-			reg = <0x100000 0x40000>;
-		};
-		partition at 6 {
-			label = "oftree";
-			reg = <0x140000 0x40000>;
-		};
-		partition at 7 {
-			label = "kernel";
-			reg = <0x180000 0x800000>;
-		};
-		partition at 8 {
-			label = "root";
-			reg = <0x980000 0x0>;
-		};
 	};
 };
 
@@ -358,26 +321,5 @@
 		status = "disabled";
 		#address-cells = <1>;
 		#size-cells = <1>;
-
-		partition at 0 {
-			label = "xload";
-			reg = <0x0 0x20000>;
-		};
-		partition at 1 {
-			label = "barebox";
-			reg = <0x20000 0x80000>;
-		};
-		partition at 2 {
-			label = "bareboxenv";
-			reg = <0xa0000 0x20000>;
-		};
-		partition at 3 {
-			label = "oftree";
-			reg = <0xc0000 0x20000>;
-		};
-		partition at 4 {
-			label = "kernel";
-			reg = <0xe0000 0x0>;
-		};
 	};
 };
-- 
1.9.1
