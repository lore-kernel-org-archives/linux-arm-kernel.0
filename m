From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:11:41 +0100
Subject: [PATCH 1/3] arm: mvebu: add XOR engines to Armada 370/XP .dtsi
In-Reply-To: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319903-30855-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary DT data in the Armada 370/XP Device
Trees.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 94b4b9e..8a3d490 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -69,6 +69,26 @@
 			compatible = "marvell,armada-addr-decoding-controller";
 			reg = <0xd0020000 0x258>;
 		};
+
+		xor at d0060900 {
+			compatible = "marvell,orion-xor";
+			reg = <0xd0060900 0x100
+			       0xd0060b00 0x100>;
+			clocks = <&coreclk 0>;
+			status = "okay";
+
+			xor00 {
+			      interrupts = <51>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			};
+			xor01 {
+			      interrupts = <52>;
+			      dmacap,memcpy;
+			      dmacap,xor;
+			      dmacap,memset;
+			};
+		};
 	};
 };
 
-- 
1.7.9.5
