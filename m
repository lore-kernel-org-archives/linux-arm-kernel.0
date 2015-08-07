From: matthias.klein@optimeas.de (Matthias Klein)
Date: Fri,  7 Aug 2015 11:09:59 +0200
Subject: [PATCH] ARM: dts: am335x-phycore-som: Move NAND partition table into
 board files
Message-ID: <1438938599-11252-1-git-send-email-matthias.klein@optimeas.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Partitions which are defined in the som file can not be deleted in the
board file.

Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 37 -------------------------
 arch/arm/boot/dts/am335x-wega.dtsi        | 45 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 4d28fc3..8f12bd54 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -189,43 +189,6 @@
 
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
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 5e541bd..945a41d 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -149,3 +149,48 @@
 &usb1_phy {
 	status = "okay";
 };
+
+&nandflash {
+	partition at 0 {
+		label = "xload";
+		reg = <0x0 0x20000>;
+	};
+
+	partition at 1 {
+		label = "xload_backup1";
+		reg = <0x20000 0x20000>;
+	};
+
+	partition at 2 {
+		label = "xload_backup2";
+		reg = <0x40000 0x20000>;
+	};
+
+	partition at 3 {
+		label = "xload_backup3";
+		reg = <0x60000 0x20000>;
+	};
+
+	partition at 4 {
+		label = "barebox";
+		reg = <0x80000 0x80000>;
+	};
+
+	partition at 5 {
+		label = "bareboxenv";
+		reg = <0x100000 0x40000>;
+	};
+
+	partition at 6 {
+		label = "oftree";
+		reg = <0x140000 0x40000>;
+	};
+	partition at 7 {
+		label = "kernel";
+		reg = <0x180000 0x800000>;
+	};
+	partition at 8 {
+		label = "root";
+		reg = <0x980000 0x0>;
+	};
+};
-- 
2.1.4
