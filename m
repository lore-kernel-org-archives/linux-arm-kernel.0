From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:57:03 +0100
Subject: [PATCH 2/4] arm: mvebu: SATA support: SoC-level DT data for Armada
 370/XP
In-Reply-To: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353423425-20574-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353423425-20574-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 94b4b9e..0abc8a1 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -69,6 +69,16 @@
 			compatible = "marvell,armada-addr-decoding-controller";
 			reg = <0xd0020000 0x258>;
 		};
+
+		sata at d00a0000 {
+			compatible = "marvell,orion-sata";
+			reg = <0xd00a0000 0x2400>;
+			interrupts = <55>;
+			clocks = <&gateclk 15>, <&gateclk 30>;
+			clock-names = "0", "1";
+			status = "disabled";
+		};
+
 	};
 };
 
-- 
1.7.9.5
