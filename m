From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 18 Apr 2016 13:06:07 +0300
Subject: [PATCH 2/2] ARM: dts: omap5-cm-t54: fix ldo1_reg and ldo4_reg ranges
In-Reply-To: <1460973967-25077-1-git-send-email-tomi.valkeinen@ti.com>
References: <1460973967-25077-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1460973967-25077-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ldo4_reg is connected to DSS, and should always be 1.8V. However the The
dts defines a range of 1.5V-1.8V, which requires somethings to set the
actual voltage at runtime. Currently we set the voltage in omapdss
driver.

As the voltage must always be 1.8V, let's just define the range to 1.8V
so that the driver doesn't need to deal with the voltage. In fact, the
driver should not touch the voltage, except in the cases where the
voltage needs to be changed at runtime.

I presume the situation is the same for ldo1_reg, used for CSI, although
I think it is not currently used in the mainline.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5-cm-t54.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index ecc591dc0778..4d87d9c6c86d 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -513,7 +513,7 @@
 				ldo1_reg: ldo1 {
 					/* VDDAPHY_CAM: vdda_csiport */
 					regulator-name = "ldo1";
-					regulator-min-microvolt = <1500000>;
+					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
 
@@ -537,7 +537,7 @@
 				ldo4_reg: ldo4 {
 					/* VDDAPHY_DISP: vdda_dsiport/hdmi */
 					regulator-name = "ldo4";
-					regulator-min-microvolt = <1500000>;
+					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 				};
 
-- 
2.5.0
