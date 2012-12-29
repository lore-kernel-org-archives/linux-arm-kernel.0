From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 29 Dec 2012 18:04:44 -0300
Subject: [PATCH] ARM: dts: omap3-igep: Add fixed always-on regulators to
 common dtsi file
Message-ID: <1356815084-6943-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These regulators are common to igep0020 and igep0030 boards
and are needed by smsc911x controller.

Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index dd01c46..91a42ce 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -24,6 +24,18 @@
 		ti,mcbsp = <&mcbsp2>;
 		ti,codec = <&twl_audio>;
 	};
+
+        vddvario: regulator-vddvario {
+                compatible = "regulator-fixed";
+                regulator-name = "vddvario";
+                regulator-always-on;
+        };
+
+        vdd33a: regulator-vdd33a {
+                compatible = "regulator-fixed";
+                regulator-name = "vdd33a";
+                regulator-always-on;
+        };
 };
 
 &omap3_pmx_core {
-- 
1.7.8.6
