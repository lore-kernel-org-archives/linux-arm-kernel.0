From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:25 +0200
Subject: [PATCH 4/9] ARM: at91/dt: enable lcd support for at91sam9x5 SoCs
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Use the at91sam9x5 display module dtsi in the relevant board dts.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g15ek.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g35ek.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x35ek.dts | 20 ++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/at91sam9g15ek.dts
index 26b0444b0f96..d1d2b400f1c6 100644
--- a/arch/arm/boot/dts/at91sam9g15ek.dts
+++ b/arch/arm/boot/dts/at91sam9g15ek.dts
@@ -8,9 +8,34 @@
  */
 /dts-v1/;
 #include "at91sam9g15.dtsi"
+#include "at91sam9x5dm.dtsi"
 #include "at91sam9x5ek.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G15-EK";
 	compatible = "atmel,at91sam9g15ek", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			hlcdc: hlcdc at f8038000 {
+				status = "okay";
+			};
+		};
+	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/at91sam9g35ek.dts
index 641a9bf89ed1..23ec8b13f30a 100644
--- a/arch/arm/boot/dts/at91sam9g35ek.dts
+++ b/arch/arm/boot/dts/at91sam9g35ek.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "at91sam9g35.dtsi"
+#include "at91sam9x5dm.dtsi"
 #include "at91sam9x5ek.dtsi"
 
 / {
@@ -20,6 +21,26 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			hlcdc: hlcdc at f8038000 {
+				status = "okay";
+			};
 		};
 	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/at91sam9x35ek.dts
index 343d32818ca3..fcb67180ea26 100644
--- a/arch/arm/boot/dts/at91sam9x35ek.dts
+++ b/arch/arm/boot/dts/at91sam9x35ek.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "at91sam9x35.dtsi"
+#include "at91sam9x5dm.dtsi"
 #include "at91sam9x5ek.dtsi"
 
 / {
@@ -20,6 +21,25 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+			hlcdc: hlcdc at f8038000 {
+				status = "okay";
+			};
 		};
 	};
+
+	backlight: backlight {
+		status = "okay";
+	};
+
+	bl_reg: backlight_regulator {
+		status = "okay";
+	};
+
+	panel: panel {
+		status = "okay";
+	};
+
+	panel_reg: panel_regulator {
+		status = "okay";
+	};
 };
-- 
2.1.4
