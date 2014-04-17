From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Apr 2014 10:46:17 +0200
Subject: [PATCH v6 6/8] ARM: sun6i: Sort the NMI node by physical address
In-Reply-To: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1397724379-15398-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT are supposed to be ordered by physical address. Move the NMI node where
it belongs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index bc46814d2ff0..5ebf963464b9 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -237,14 +237,6 @@
 		#size-cells = <1>;
 		ranges;
 
-		nmi_intc: interrupt-controller at 01f00c0c {
-			compatible = "allwinner,sun6i-a31-sc-nmi";
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x01f00c0c 0x38>;
-			interrupts = <0 32 4>;
-		};
-
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
@@ -479,6 +471,14 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		nmi_intc: interrupt-controller at 01f00c0c {
+			compatible = "allwinner,sun6i-a31-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c0c 0x38>;
+			interrupts = <0 32 4>;
+		};
+
 		prcm at 01f01400 {
 			compatible = "allwinner,sun6i-a31-prcm";
 			reg = <0x01f01400 0x200>;
-- 
1.9.1
