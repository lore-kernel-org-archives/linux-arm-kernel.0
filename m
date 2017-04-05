From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed,  5 Apr 2017 11:06:31 +0200
Subject: [PATCH v4 5/8] ARM: sun8i: a33: add thermal sensor
In-Reply-To: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
Message-ID: <20170405090634.4649-6-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT node for the thermal sensor present in the Allwinner
A33 GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v3:
  - switched compatible to allwinner,sun8i-a33-ths,
  - renamed DT node name and label to ths to better match datasheet's name,

 arch/arm/boot/dts/sun8i-a33.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 077db22..9734e63 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -266,6 +266,13 @@
 			status = "disabled";
 		};
 
+		ths: ths at 01c25000 {
+			compatible = "allwinner,sun8i-a33-ths";
+			reg = <0x01c25000 0x100>;
+			#thermal-sensor-cells = <0>;
+			#io-channel-cells = <0>;
+		};
+
 		fe0: display-frontend at 01e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
@@ -376,6 +383,11 @@
 			};
 		};
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ths>;
+	};
 };
 
 &ccu {
-- 
2.9.3
