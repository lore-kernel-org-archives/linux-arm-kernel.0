From: stefan@agner.ch (Stefan Agner)
Date: Mon, 22 Sep 2014 19:09:23 +0200
Subject: [PATCH 2/9] ARM: dts: vf610: add global power controller (GPC)
In-Reply-To: <cover.1411404079.git.stefan@agner.ch>
References: <cover.1411404079.git.stefan@agner.ch>
Message-ID: <21796ac49b3b40094cdea25f6d7c887dc53eefab.1411404079.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add global power controller module (GPC) to Vybrid device tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 122a64956..67bb3b7 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -367,6 +367,11 @@
 				clocks = <&clks VF610_CLK_USBC0>;
 			};
 
+			gpc: gpc at 4006c000 {
+				compatible = "fsl,vf610-gpc";
+				reg = <0x4006c000 0x1000>;
+			};
+
 			src: src at 4006e000 {
 				compatible = "fsl,vf610-src";
 				reg = <0x4006e000 0x1000>;
-- 
2.1.0
