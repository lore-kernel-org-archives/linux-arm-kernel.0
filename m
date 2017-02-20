From: jagan@openedev.com (Jagan Teki)
Date: Tue, 21 Feb 2017 01:35:21 +0530
Subject: [PATCH v2 4/4] arm: dts: imx6q-icore: Add LVDS support
In-Reply-To: <1487621121-6051-1-git-send-email-jagan@openedev.com>
References: <1487621121-6051-1-git-send-email-jagan@openedev.com>
Message-ID: <1487621121-6051-4-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LVDS display support for OpenFrame Capacitive touch 7 inc
display which is supported by Engicam i.CoreM6 QDL Starter Kit.

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@openedev.com>
---
Changes for v2:
- newly added patch

 arch/arm/boot/dts/imx6q-icore.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 59eb7ad..e6216da 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -57,3 +57,28 @@
 &can2 {
 	status = "okay";
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
+                        native-mode = <&timing1>;
+                        timing1: hsd100pxn1 {
+                                clock-frequency = <60000000>;
+                                hactive = <800>;
+                                vactive = <480>;
+                                hback-porch = <30>;
+                                hfront-porch = <30>;
+                                vback-porch = <5>;
+                                vfront-porch = <5>;
+                                hsync-len = <64>;
+                                vsync-len = <20>;
+                        };
+                };
+	};
+};
-- 
1.9.1
