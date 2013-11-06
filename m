From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed,  6 Nov 2013 09:25:15 +0100
Subject: [PATCH v6 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
In-Reply-To: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
References: <1383726315-27534-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1383726315-27534-5-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies I2C configuration to B2000 and B2020
based on either STiH415 or STiH416 SoCs.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi |    9 +++++++++
 arch/arm/boot/dts/stih41x-b2020.dtsi |   22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index 8e694d2..1e6aa92 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -37,5 +37,14 @@
 			};
 		};
 
+		/* HDMI Tx I2C */
+		i2c at fed41000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+			i2c-min-scl-pulse-width-us = <0>;
+			i2c-min-sda-pulse-width-us = <5>;
+
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index 133e181..0ef0a69 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -38,5 +38,27 @@
 				default-state = "off";
 			};
 		};
+
+		i2c at fed40000 {
+			status = "okay";
+		};
+
+		/* HDMI Tx I2C */
+		i2c at fed41000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+			i2c-min-scl-pulse-width-us = <0>;
+			i2c-min-sda-pulse-width-us = <5>;
+
+			status = "okay";
+		};
+
+		i2c at fe540000 {
+			status = "okay";
+		};
+
+		i2c at fe541000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
