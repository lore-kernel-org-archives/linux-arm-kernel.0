From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 16:14:21 +0100
Subject: [PATCH 4/4] arm: mvebu: add XOR engines to Armada XP .dtsi
In-Reply-To: <1353424461-25421-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353424461-25421-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353424461-25421-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi |   40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index f51554e..a099985 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -71,5 +71,45 @@
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x500>;
 		};
+
+		xor at d0060900 {
+			compatible = "marvell,orion-xor";
+			reg = <0xd0060900 0x100
+			       0xd0060b00 0x100>;
+			clocks = <&gateclk 22>;
+			status = "okay";
+
+			xor10 {
+				interrupts = <51>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+			xor11 {
+				interrupts = <52>;
+				dmacap,memcpy;
+				dmacap,xor;
+				dmacap,memset;
+			};
+		};
+
+		xor at d00f0900 {
+			compatible = "marvell,orion-xor";
+			reg = <0xd00F0900 0x100
+			       0xd00F0B00 0x100>;
+			clocks = <&gateclk 28>;
+			status = "okay";
+
+			xor00 {
+				interrupts = <94>;
+				dmacap,memcpy;
+				dmacap,xor;
+			};
+			xor01 {
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
