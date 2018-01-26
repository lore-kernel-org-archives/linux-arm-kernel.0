From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 26 Jan 2018 16:19:39 +0100
Subject: [PATCH 14/16] arm: dts: sun8i: h3: enable H3 sid controller
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
Message-ID: <20180126151941.12183-15-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the the sid controller in the H3. It can be used
for thermal calibration data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3f83f6a27c74..9bb5cc29fec5 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -72,6 +72,13 @@
 		};
 	};
 
+	soc {
+		sid: eeprom at 1c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x01c14000 0x400>;
+		};
+	};
+
 	thermal-zones {
 		cpu-thermal {
 			/* milliseconds */
-- 
2.11.0
