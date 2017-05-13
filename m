From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 14 May 2017 02:20:50 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: fix simple-bus unit address format
 error
In-Reply-To: <1494696050-4615-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494696050-4615-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1494696050-4615-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling the UniPhier DT files with W=1, DTC warns like follows:

Warning (simple_bus_reg): Node /soc/smpctrl at 59800000 simple-bus unit address format error, expected "59801000"

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index dc0cd94..20bea49 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -268,7 +268,7 @@
 			pinctrl-0 = <&pinctrl_system_bus>;
 		};
 
-		smpctrl at 59800000 {
+		smpctrl at 59801000 {
 			compatible = "socionext,uniphier-smpctrl";
 			reg = <0x59801000 0x400>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index c7bd006..4b856af 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -337,7 +337,7 @@
 			pinctrl-0 = <&pinctrl_system_bus>;
 		};
 
-		smpctrl at 59800000 {
+		smpctrl at 59801000 {
 			compatible = "socionext,uniphier-smpctrl";
 			reg = <0x59801000 0x400>;
 		};
-- 
2.7.4
