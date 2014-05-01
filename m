From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 30 Apr 2014 23:34:04 -0700
Subject: [PATCH 2/2] ARM: dts: imx: Fix LVDS mapping for Ventana GW52xx
In-Reply-To: <20140429055531.GF16451@dragon>
References: <20140429055531.GF16451@dragon>
Message-ID: <1398926044-26125-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW52xx supports LVDS on channel 0. Remove the obsolete crtcs node and
add display timings for the HanStar HSD100PXN1 display.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 62f533a..367af3e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -454,6 +454,27 @@
 
 &ldb {
 	status = "okay";
+
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
+		};
+	};
 };
 
 &pcie {
-- 
1.8.3.2
