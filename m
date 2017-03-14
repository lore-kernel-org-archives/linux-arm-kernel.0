From: jagan@openedev.com (Jagan Teki)
Date: Tue, 14 Mar 2017 15:18:13 +0530
Subject: [PATCH v5 4/8] ARM: dts: imx6q-icore: Add LVDS support
In-Reply-To: <1489484897-14933-1-git-send-email-jagan@openedev.com>
References: <1489484897-14933-1-git-send-email-jagan@openedev.com>
Message-ID: <1489484897-14933-5-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add LVDS display support for OpenFrame Capacitive touch 7 inc
display which is supported by Engicam i.CoreM6 QDL Starter Kit.

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- %s/arm/ARM/g with subject prefix
Changes for v4:
- Fix checkpatch.pl Errors/Warnings
Changes for v3:
- Use native-mode as timing0 since this is the initial lvds-channel
- Rename hsd100pxn1 reference as timing0
- Update the correct patch author
Changes for v2:
- none

 arch/arm/boot/dts/imx6q-icore.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 59eb7ad..73f34d1 100644
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
