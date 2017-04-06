From: jagan@openedev.com (Jagan Teki)
Date: Thu,  6 Apr 2017 23:32:13 +0530
Subject: [PATCH v3 7/9] ARM: dts: imx6dl-icore: Add touchscreen node
In-Reply-To: <1491501735-1649-1-git-send-email-jagan@openedev.com>
References: <1491501735-1649-1-git-send-email-jagan@openedev.com>
Message-ID: <1491501735-1649-8-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 DualLite/Solo module is
connected via i2c1, so add max11801: touchscreen at 48 on i2c1.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3,v2:
- none

 arch/arm/boot/dts/imx6dl-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index ea9ab05..27f37cd 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&i2c1 {
+	max11801: touchscreen at 48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &i2c3 {
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
-- 
1.9.1
