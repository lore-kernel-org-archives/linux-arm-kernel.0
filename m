From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  6 Feb 2018 12:49:04 +0800
Subject: [PATCH v2 09/10] ARM: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Message-ID: <20180206044905.30508-10-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VDD-CPUX voltage of ALL-H3-CC H3 ver should be 1.2V, not the 3.3V
currently defined in the device tree.

Fix the voltage in the device tree.

Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre Computer Board ALL-H3-CC H3 ver.")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v2.

 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index d406571a0dd6..ca974d872357 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -102,8 +102,8 @@
 	reg_vdd_cpux: vdd-cpux {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd-cpux";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
 		regulator-always-on;
 		regulator-boot-on;
 		vin-supply = <&reg_vcc5v0>;
-- 
2.15.1
