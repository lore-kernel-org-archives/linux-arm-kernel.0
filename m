From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Jul 2018 10:35:38 +0200
Subject: [PATCH v2] ARM: dts: ux500: Get rid of DTC warnings
Message-ID: <20180703083538.7058-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By removing the reference to skeleton.dtsi, defining chosen {}
and proper memory nodes we get warning-free device trees for
the Ux500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Erroneously added two new memory {} nodes: actually there is
  an overarching dtsi file for all HREF boards, so just fix up
  that memory node with a device_type.
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi  | 7 ++++++-
 arch/arm/boot/dts/ste-href.dtsi    | 1 +
 arch/arm/boot/dts/ste-snowball.dts | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 3dc0028e108b..a58ce6f68d7d 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -15,9 +15,14 @@
 #include <dt-bindings/arm/ux500_pm_domains.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/ste-ab8500.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 9e359e4f342e..feb682a3d363 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -15,6 +15,7 @@
 
 / {
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b0b94d053098..8fa025251dc6 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -26,6 +26,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
-- 
2.17.0
