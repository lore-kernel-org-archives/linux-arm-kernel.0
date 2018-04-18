From: srinath.mannam@broadcom.com (Srinath Mannam)
Date: Wed, 18 Apr 2018 14:11:29 +0530
Subject: [PATCH] arm64: dts: correct SATA addresses for Stingray
Message-ID: <1524040889-6876-1-git-send-email-srinath.mannam@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct all SATA ahci and phy controller register
addresses and interrupt lines to proper values.

Fixes: 344a2e514182 ("arm64: dts: Add SATA DT nodes for Stingray SoC")

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Andrew Gospodarek <andrew.gospodarek@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-sata.dtsi  | 80 +++++++++++-----------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
index 4b5465d..8c68e0c 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
@@ -36,11 +36,11 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x67d00000 0x00800000>;
 
-		sata0: ahci at 210000 {
+		sata0: ahci at 0 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00210000 0x1000>;
+			reg = <0x00000000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -52,9 +52,9 @@
 			};
 		};
 
-		sata_phy0: sata_phy at 212100 {
+		sata_phy0: sata_phy at 2100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00212100 0x1000>;
+			reg = <0x00002100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -66,11 +66,11 @@
 			};
 		};
 
-		sata1: ahci at 310000 {
+		sata1: ahci at 10000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00310000 0x1000>;
+			reg = <0x00010000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -82,9 +82,9 @@
 			};
 		};
 
-		sata_phy1: sata_phy at 312100 {
+		sata_phy1: sata_phy at 12100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00312100 0x1000>;
+			reg = <0x00012100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -96,11 +96,11 @@
 			};
 		};
 
-		sata2: ahci at 120000 {
+		sata2: ahci at 20000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00120000 0x1000>;
+			reg = <0x00020000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -112,9 +112,9 @@
 			};
 		};
 
-		sata_phy2: sata_phy at 122100 {
+		sata_phy2: sata_phy at 22100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00122100 0x1000>;
+			reg = <0x00022100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -126,11 +126,11 @@
 			};
 		};
 
-		sata3: ahci at 130000 {
+		sata3: ahci at 30000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00130000 0x1000>;
+			reg = <0x00030000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -142,9 +142,9 @@
 			};
 		};
 
-		sata_phy3: sata_phy at 132100 {
+		sata_phy3: sata_phy at 32100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00132100 0x1000>;
+			reg = <0x00032100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -156,11 +156,11 @@
 			};
 		};
 
-		sata4: ahci at 330000 {
+		sata4: ahci at 100000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00330000 0x1000>;
+			reg = <0x00100000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -172,9 +172,9 @@
 			};
 		};
 
-		sata_phy4: sata_phy at 332100 {
+		sata_phy4: sata_phy at 102100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00332100 0x1000>;
+			reg = <0x00102100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -186,11 +186,11 @@
 			};
 		};
 
-		sata5: ahci at 400000 {
+		sata5: ahci at 110000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00400000 0x1000>;
+			reg = <0x00110000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -202,9 +202,9 @@
 			};
 		};
 
-		sata_phy5: sata_phy at 402100 {
+		sata_phy5: sata_phy at 112100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00402100 0x1000>;
+			reg = <0x00112100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -216,11 +216,11 @@
 			};
 		};
 
-		sata6: ahci at 410000 {
+		sata6: ahci at 120000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00410000 0x1000>;
+			reg = <0x00120000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -232,9 +232,9 @@
 			};
 		};
 
-		sata_phy6: sata_phy at 412100 {
+		sata_phy6: sata_phy at 122100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00412100 0x1000>;
+			reg = <0x00122100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -246,11 +246,11 @@
 			};
 		};
 
-		sata7: ahci at 420000 {
+		sata7: ahci at 130000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
-			reg = <0x00420000 0x1000>;
+			reg = <0x00130000 0x1000>;
 			reg-names = "ahci";
-			interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -262,9 +262,9 @@
 			};
 		};
 
-		sata_phy7: sata_phy at 422100 {
+		sata_phy7: sata_phy at 132100 {
 			compatible = "brcm,iproc-sr-sata-phy";
-			reg = <0x00422100 0x1000>;
+			reg = <0x00132100 0x1000>;
 			reg-names = "phy";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
