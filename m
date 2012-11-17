From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:22:30 +0100
Subject: [PATCH v2 9/9] arm: mvebu: armada 370/XP adding clock gating support:
 dt binding
In-Reply-To: <1353162150-522-1-git-send-email-andrew@lunn.ch>
References: <1353162150-522-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353162150-522-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-370.dtsi |    8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi  |    7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index dae966c..20ce596 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -82,5 +82,13 @@
 			#clock-cells = <1>;
 		};
 
+		gateclk: clock-gating-control at d0018220 {
+			compatible = "marvell,armada-370-gating-clock";
+			reg = <0xd0018220 0x4>;
+			clocks = <&coreclk 0>;
+			#clock-cells = <1>;
+		};
+
+
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index f8382a8..9b0da25 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -89,6 +89,13 @@
 			clocks = <&coreclk 1>;
 		};
 
+		gateclk: clock-gating-control at d001821c {
+			compatible = "marvell,armada-xp-gating-clock";
+			reg = <0xd001821c 0x4>;
+			clocks = <&coreclk 0>;
+			#clock-cells = <1>;
+		};
+
 		system-controller at d0018200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x500>;
-- 
1.7.10.4
