From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Wed,  8 Aug 2018 00:00:10 +0200
Subject: [PATCH v2 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
In-Reply-To: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
Message-ID: <20180807220011.24436-4-maxi.jourdan@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrap the canvas node in a syscon node.

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4dbb391b..c98198662ae2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -423,6 +423,23 @@
 			};
 		};
 
+		dmcbus: bus at c8838000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xc8838000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
+
+			sysctrl_DMC: system-controller at 0 {
+				compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
+				reg = <0x0 0x0 0x0 0x1000>;
+
+				canvas: canvas-provider at 0 {
+					compatible = "amlogic,canvas";
+				};
+			};
+		};
+
 		hiubus: bus at c883c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc883c000 0x0 0x2000>;
-- 
2.18.0
