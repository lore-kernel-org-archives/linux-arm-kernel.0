From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 9 Jul 2012 16:01:01 +0530
Subject: [PATCH 1/6] ARM: DTS: SPEAr13xx: Fix Interrupt bindings
Message-ID: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

   - Fix interrupt bindings for uart, ethernet and pmu.
   - Add interrupt binding for keyboard.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/boot/dts/spear13xx.dtsi |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 10dcec7..f7b84ac 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -43,8 +43,8 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 8 0x04
-			      0 9 0x04>;
+		interrupts = <0 6 0x04
+			      0 7 0x04>;
 	};
 
 	L2: l2-cache {
@@ -119,8 +119,8 @@
 		gmac0: eth at e2000000 {
 			compatible = "st,spear600-gmac";
 			reg = <0xe2000000 0x8000>;
-			interrupts = <0 23 0x4
-				      0 24 0x4>;
+			interrupts = <0 33 0x4
+				      0 34 0x4>;
 			interrupt-names = "macirq", "eth_wake_irq";
 			status = "disabled";
 		};
@@ -202,6 +202,7 @@
 			kbd at e0300000 {
 				compatible = "st,spear300-kbd";
 				reg = <0xe0300000 0x1000>;
+				interrupts = <0 52 0x4>;
 				status = "disabled";
 			};
 
@@ -224,7 +225,7 @@
 			serial at e0000000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xe0000000 0x1000>;
-				interrupts = <0 36 0x4>;
+				interrupts = <0 35 0x4>;
 				status = "disabled";
 			};
 
-- 
1.7.10
