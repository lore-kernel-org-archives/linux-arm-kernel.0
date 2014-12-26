From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 26 Dec 2014 22:09:49 +0200
Subject: [PATCH] ARM: OMAP: DTS: N950/N9: add twl_power
Message-ID: <1419624589-10432-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add twl_power for N950/N9. Start with the simplest configuration to just
enable power off.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 1e49dfe..c41db94 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -60,6 +60,11 @@
 
 &twl {
 	compatible = "ti,twl5031";
+
+	twl_power: power {
+		compatible = "ti,twl4030-power";
+		ti,use_poweroff;
+	};
 };
 
 &twl_gpio {
-- 
2.2.0
