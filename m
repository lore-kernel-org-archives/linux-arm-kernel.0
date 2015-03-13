From: b52261@freescale.com (Jianwei Wang)
Date: Fri, 13 Mar 2015 17:44:19 +0800
Subject: [PATCH 3/3] arm/dts/ls1021a: Add a TFT LCD panel dts node for DCU
In-Reply-To: <1426239859-29254-1-git-send-email-b52261@freescale.com>
References: <1426239859-29254-1-git-send-email-b52261@freescale.com>
Message-ID: <1426239859-29254-3-git-send-email-b52261@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a required display-timings node for the TFT LCD panel
the TFT LCD panel is WQVGA "480x272", and the bpp is 24.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <b52261@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..4780b11 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -58,6 +58,32 @@
 	};
 };
 
+&dcu {
+	display = <&display>;
+	status = "okay";
+
+	display: display at 0 {
+		bits-per-pixel = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: nl4827hc19 {
+				clock-frequency = <10870000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vfront-porch = <2>;
+				hsync-len = <41>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
+};
+
 &dspi1 {
 	bus-num = <0>;
 	status = "okay";
-- 
2.1.0.27.g96db324
