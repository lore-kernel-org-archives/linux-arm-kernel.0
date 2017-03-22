From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 23:18:15 +0530
Subject: [PATCH 10/12] ARM: dts: imx6dl-icore: Add LVDS support
In-Reply-To: <1490204897-14525-1-git-send-email-jagan@openedev.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
Message-ID: <1490204897-14525-11-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add LVDS display support for OpenFrame Capacitive touch 7 inc
display which is supported by Engicam i.CoreM6 DualLite/Solo Starter Kit.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-icore.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index c132ccd..3abae7f 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
@@ -68,3 +68,28 @@
 		VDDD-supply = <&reg_1p8v>;
 	};
 };
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <60000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <30>;
+				hfront-porch = <30>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <64>;
+				vsync-len = <20>;
+			};
+		};
+	};
+};
-- 
1.9.1
