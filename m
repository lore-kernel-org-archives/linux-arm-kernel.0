From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 00:21:37 +0900
Subject: [PATCH] arm64: dts: uniphier: add eMMC hardware reset provider node
Message-ID: <1508772097-18752-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mmc-pwrseq-emmc node to perform standard eMMC hardware reset
procedure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 8 ++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 7 +++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 5fde6f5..e8bd39c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 /memreserve/ 0x80000000 0x02000000;
 
 / {
@@ -96,6 +98,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>,
@@ -310,6 +317,7 @@
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
+			mmc-pwrseq = <&emmc_pwrseq>;
 			cdns,phy-input-delay-legacy = <4>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index aae64d2..e7e9826 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -7,6 +7,7 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/thermal/thermal.h>
 
 /memreserve/ 0x80000000 0x02000000;
@@ -169,6 +170,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>,
@@ -416,6 +422,7 @@
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
+			mmc-pwrseq = <&emmc_pwrseq>;
 			cdns,phy-input-delay-legacy = <4>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 7e990e3..6297a2d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 /memreserve/ 0x80000000 0x02000000;
 
 / {
@@ -124,6 +126,11 @@
 		};
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>,
@@ -317,6 +324,7 @@
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
+			mmc-pwrseq = <&emmc_pwrseq>;
 			cdns,phy-input-delay-legacy = <4>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
-- 
2.7.4
