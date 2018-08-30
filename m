From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:45:14 +0200
Subject: [PATCH v3 26/30] ARM: dts: sun8i: h3: enable H3 sid controller
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-27-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the the sid controller in the H3. It can be used
for thermal calibration data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 954848d5df50..1866aec69ec1 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -104,6 +104,13 @@
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
