From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Oct 2013 19:41:19 +0200
Subject: [PATCH v2 1/2] ARM: Dove: Add the audio devices in DT
Message-ID: <20131008194119.0cebbe26@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the nodes to instantiate the audio devices of the Dove
boards.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/dove.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index cc27916..e177e66 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -505,5 +505,23 @@
 				phy-handle = <&ethphy>;
 			};
 		};
+
+		audio0: audio-controller at b0000 {
+			compatible = "marvell,dove-audio";
+			reg = <0xb0000 0x2210>;
+			interrupts = <19>, <20>;
+			clocks = <&gate_clk 12>;
+			clock-names = "internal";
+			status = "disabled";
+		};
+
+		audio1: audio-controller at b4000 {
+			compatible = "marvell,dove-audio";
+			reg = <0xb4000 0x2210>;
+			interrupts = <21>, <22>;
+			clocks = <&gate_clk 13>;
+			clock-names = "internal";
+			status = "disabled";
+		};
 	};
 };

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
