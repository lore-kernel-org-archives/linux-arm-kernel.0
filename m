From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 16 Jan 2014 16:39:06 +0100
Subject: [PATCH] ARM: moxart: move fixed rate clock child node to board level
 dts
Message-ID: <1389886746-972-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a skeleton "clocks { .. }" remain in .dtsi, the child node can
be moved to .dts, "ref12" is then found by of_clk_get().

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Applies to next-20140116

 arch/arm/boot/dts/moxart-uc7112lx.dts | 8 ++++++++
 arch/arm/boot/dts/moxart.dtsi         | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts b/arch/arm/boot/dts/moxart-uc7112lx.dts
index 90749d5..10d088d 100644
--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -17,6 +17,14 @@
 		reg = <0x0 0x2000000>;
 	};
 
+	clocks {
+		ref12: ref12M {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12000000>;
+		};
+	};
+
 	flash at 80000000,0 {
 		compatible = "numonyx,js28f128", "cfi-flash";
 		reg = <0x80000000 0x1000000>;
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index da1d8ef..1fd27ed 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -26,12 +26,6 @@
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		ref12: ref12M {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <12000000>;
-		};
 	};
 
 	soc {
-- 
1.8.2.1
