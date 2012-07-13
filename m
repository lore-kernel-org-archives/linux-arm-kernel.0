From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:48 +0530
Subject: [PATCH V2 1/7] ARM: SPEAr13xx: Fix Interrupt bindings
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <6f2947a4b7c2eb5e5d29f34e494b181be79cf1ef.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-Correct interrupt bindings for uart, ethernet and pmu.
-Added interrupt binding for keyboard.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Acked-by: Viiresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear13xx.dtsi |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

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
1.7.2.2
