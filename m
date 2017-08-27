From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 27 Aug 2017 21:03:06 +0900
Subject: [PATCH 1/2] arm64: dts: uniphier: add AIDET nodes
Message-ID: <1503835387-9815-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UniPhier AIDET (ARM Interrupt Detector) nodes to support
active low interrupts.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 7 +++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 5537a457af97..ee4aff53a5f5 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -355,6 +355,13 @@
 			};
 		};
 
+		aidet: aidet at 5fc20000 {
+			compatible = "socionext,uniphier-ld11-aidet";
+			reg = <0x5fc20000 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		gic: interrupt-controller at 5fe00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x5fe00000 0x10000>,	/* GICD */
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 304cb743d70c..f4948d0aa348 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -376,6 +376,13 @@
 			};
 		};
 
+		aidet: aidet at 5fc20000 {
+			compatible = "socionext,uniphier-ld20-aidet";
+			reg = <0x5fc20000 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		gic: interrupt-controller at 5fe00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x5fe00000 0x10000>,	/* GICD */
-- 
2.7.4
