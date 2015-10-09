From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 19:56:49 +0800
Subject: [PATCH v5 6/7] arm64: dts: berlin4ct: add the pinctrl node
In-Reply-To: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
References: <1444391810-5045-1-git-send-email-jszhang@marvell.com>
Message-ID: <1444391810-5045-7-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the avio, soc, sm pinctrl nodes for Marvell berlin4ct SoC.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index a3b5f1d..8e66355 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -225,6 +225,16 @@
 			};
 		};
 
+		soc_pinctrl: pin-controller at ea8000 {
+			compatible = "marvell,berlin4ct-soc-pinctrl";
+			reg = <0xea8000 0x14>;
+		};
+
+		avio_pinctrl: pin-controller at ea8400 {
+			compatible = "marvell,berlin4ct-avio-pinctrl";
+			reg = <0xea8400 0x8>;
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -280,5 +290,10 @@
 				status = "disabled";
 			};
 		};
+
+		system_pinctrl: pin-controller at fe2200 {
+			compatible = "marvell,berlin4ct-system-pinctrl";
+			reg = <0xfe2200 0xc>;
+		};
 	};
 };
-- 
2.6.1
