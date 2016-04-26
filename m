From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:30 +0200
Subject: [PATCH v3 02/11] arm64: dts: marvell: clean up armada-7040-db
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Instead of duplicating the node hierarchy, reference the nodes by label,
adding labels where necessary.

Drop some trailing or inconsistent white lines while at it.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
[Thomas: drop Fixes tag as it is not a bug fix.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 52 ++++++++++------------
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  1 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  2 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  7 +--
 4 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 064a251..ee57783 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -55,38 +55,34 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+};
 
-	ap806 {
-		config-space {
-			spi at 510600 {
-				status = "okay";
-
-				spi-flash at 0 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "n25q128a13";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <10000000>;
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
 
-					partition at 0 {
-						label = "U-Boot";
-						reg = <0 0x200000>;
-					};
-					partition at 400000 {
-						label = "Filesystem";
-						reg = <0x200000 0xce0000>;
-					};
-				};
-			};
+&spi0 {
+	status = "okay";
 
-			i2c at 511000 {
-				status = "okay";
-				clock-frequency = <100000>;
-			};
+	spi-flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <10000000>;
 
-			serial at 512000 {
-				status = "okay";
-			};
+		partition at 0 {
+			label = "U-Boot";
+			reg = <0 0x200000>;
+		};
+		partition at 400000 {
+			label = "Filesystem";
+			reg = <0x200000 0xce0000>;
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
index f25c5c1..95a1ff6 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
@@ -68,4 +68,3 @@
 		};
 	};
 };
-
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index baa7d9a..ba43a43 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -79,6 +79,4 @@
 			enable-method = "psci";
 		};
 	};
-
 };
-
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 556a92b..3ecf9b1 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -59,7 +59,6 @@
 		method = "smc";
 	};
 
-
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -190,7 +189,7 @@
 				status = "disabled";
 			};
 
-			serial at 512000 {
+			uart0: serial at 512000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x512000 0x100>;
 				reg-shift = <2>;
@@ -200,7 +199,7 @@
 				status = "disabled";
 			};
 
-			serial at 512100 {
+			uart1: serial at 512100 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x512100 0x100>;
 				reg-shift = <2>;
@@ -232,6 +231,4 @@
 			};
 		};
 	};
-
 };
-
-- 
2.6.4
