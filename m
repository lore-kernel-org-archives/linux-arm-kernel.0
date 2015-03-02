From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 2 Mar 2015 14:03:29 +0800
Subject: [PATCH] ARM: dts: at919260/at91sam9g20: fix SRAM device tree node
Message-ID: <1425276209-4899-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PM does not work on the at91sam9g20ek board
--->8---
at91_pm_sram_init: failed to find sram device!
---<8---

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi |    9 +++++++--
 arch/arm/boot/dts/at91sam9g20.dtsi |    9 +++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index fff0ee6..d1eb27c 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -69,9 +69,14 @@
 		};
 	};
 
-	sram0: sram at 002ff000 {
+	sram0: sram at 00200000 {
 		compatible = "mmio-sram";
-		reg = <0x002ff000 0x2000>;
+		reg = <0x00200000 0x1000>;
+	};
+
+	sram1: sram at 00300000 {
+		compatible = "mmio-sram";
+		reg = <0x00300000 0x1000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index f593016..eb9a62d 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -16,13 +16,14 @@
 		reg = <0x20000000 0x08000000>;
 	};
 
-	sram0: sram at 002ff000 {
-		status = "disabled";
+	sram0: sram at 00200000 {
+		compatible = "mmio-sram";
+		reg = <0x00200000 0x4000>;
 	};
 
-	sram1: sram at 002fc000 {
+	sram1: sram at 00300000 {
 		compatible = "mmio-sram";
-		reg = <0x002fc000 0x8000>;
+		reg = <0x00300000 0x4000>;
 	};
 
 	ahb {
-- 
1.7.9.5
