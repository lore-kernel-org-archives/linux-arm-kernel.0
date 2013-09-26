From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 26 Sep 2013 11:54:29 +0200
Subject: [PATCH v2 4/4] ARM: STi: Add I2C config to B2000 and B2020 boards
Message-ID: <1380189269-5906-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies I2C configuration to B2000 and B2020
based on either STiH415 or STiH416 SoCs.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi |    7 +++++++
 arch/arm/boot/dts/stih41x-b2020.dtsi |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index 8e694d2..0078a9e 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -37,5 +37,12 @@
 			};
 		};
 
+		/* HDMI Tx I2C */
+		i2c at fed41000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index 133e181..70ce017 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -38,5 +38,25 @@
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
