From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Wed, 25 Jul 2012 15:05:23 +0400
Subject: [PATCH v4 4/4] ARM: DT: Add support to system control module for OMAP4
Message-ID: <500FD2F3.6060109@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 arch/arm/boot/dts/omap4.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..59f83c9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -295,5 +295,15 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
 		};
+
+		ctrl_module_core: ctrl_module_core at 4A0022C4 {
+			compatible = "ti,omap4-control";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* ranges; */
+			ti,hwmods = "ctrl_module_core";
+			reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
+		};
+
 	};
 };
-- 
1.7.7.6
