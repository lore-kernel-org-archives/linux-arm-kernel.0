From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 16:14:20 +0100
Subject: [PATCH 3/4] arm: mvebu: add XOR engines to Armada 370 .dtsi
In-Reply-To: <1353424461-25421-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353424461-25421-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353424461-25421-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 175df28..7fbac28 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -89,6 +89,42 @@
 			#clock-cells = <1>;
 		};
 
+		xor at d0060800 {
+			compatible = "marvell,orion-xor";
+			reg = <0xd0060800 0x100
+			       0xd0060A00 0x100>;
+			status = "okay";
 
+			xor00 {
+				interrupts = <51>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+			xor01 {
+				interrupts = <52>;
+				dmacap,memcpy;
+				dmacap,xor;
+				dmacap,memset;
+			};
+		};
+
+		xor at d0060900 {
+			compatible = "marvell,orion-xor";
+			reg = <0xd0060900 0x100
+			       0xd0060b00 0x100>;
+			status = "okay";
+
+			xor10 {
+				interrupts = <94>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+			xor11 {
+				interrupts = <95>;
+				dmacap,memcpy;
+				dmacap,xor;
+				dmacap,memset;
+			};
+		};
 	};
 };
-- 
1.7.9.5
