From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 11 Sep 2017 14:42:23 +0530
Subject: [PATCH v4 4/6] ARM: dts: imx6dl-icore: Add LVDS support
In-Reply-To: <1505121145-9507-1-git-send-email-jteki@openedev.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
Message-ID: <1505121145-9507-4-git-send-email-jteki@openedev.com>
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
Changes for v4, v3, v2:
- none

 arch/arm/boot/dts/imx6dl-icore.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index 6de83c7..360c32e 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
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
2.7.4
