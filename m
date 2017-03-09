From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Mar 2017 13:35:56 +0530
Subject: [PATCH v2 2/8] ARM: DRA7: Thermal: Add slope and offset values
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1489046762-11288-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 2c9e56f..10e09dc 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1982,6 +1982,23 @@
 
 &cpu_thermal {
 	polling-delay = <500>; /* milliseconds */
+	coefficients = <0 2000>;
+};
+
+&gpu_thermal {
+	coefficients = <0 2000>;
+};
+
+&core_thermal {
+	coefficients = <0 2000>;
+};
+
+&dspeve_thermal {
+	coefficients = <0 2000>;
+};
+
+&iva_thermal {
+	coefficients = <0 2000>;
 };
 
 /include/ "dra7xx-clocks.dtsi"
-- 
1.9.1
