From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Wed, 27 Jun 2012 22:05:16 +0400
Subject: [PATCH v3 7/7] ARM: DT: Add support to system control module for OMAP4
Message-ID: <4FEB4B5C.5020109@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..8ecf80a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,20 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		ctrl_module_core: ctrl_module_core at 4a002000 {
+			compatible = "ti,omap4-control";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ctrl_module_core";
+			reg = <0x4a002000 0x1000>;
+			bandgap at 4a002000 {
+				compatible = "ti,omap4-bandgap";
+			};
+			usb at 4a002000 {
+				compatible = "ti,omap4-usb-phy";
+			};
+		};
 	};
 };
-- 
1.7.7.6
