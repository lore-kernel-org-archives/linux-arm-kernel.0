From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:39 -0300
Subject: [PATCH v2 3/7] arm: sunxi: use the right clock phandles for UARTs
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the UARTs are connected to clock gates; now that our clock driver
is able to handle them, make the switch.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from v1:
  - no changes

 arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++------
 arch/arm/boot/dts/sunxi.dtsi     |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 68a27fc..6b3a6b2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -54,7 +54,7 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 16>;
 			status = "disabled";
 		};
 
@@ -64,7 +64,7 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 18>;
 			status = "disabled";
 		};
 
@@ -74,7 +74,7 @@
 			interrupts = <17>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 20>;
 			status = "disabled";
 		};
 
@@ -84,7 +84,7 @@
 			interrupts = <18>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 21>;
 			status = "disabled";
 		};
 
@@ -94,7 +94,7 @@
 			interrupts = <19>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 22>;
 			status = "disabled";
 		};
 
@@ -104,7 +104,7 @@
 			interrupts = <20>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 23>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 87b2cce..a8d47e2 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -191,7 +191,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 17>;
 			status = "disabled";
 		};
 
@@ -201,7 +201,7 @@
 			interrupts = <4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc>;
+			clocks = <&apb1_gates 19>;
 			status = "disabled";
 		};
 	};
-- 
1.8.2
