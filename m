From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Mar 2017 13:35:57 +0530
Subject: [PATCH v2 3/8] ARM: OMAP5: Thermal: Add slope and offset values
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1489046762-11288-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 222155c..eaff2a5 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -1127,6 +1127,15 @@
 
 &cpu_thermal {
 	polling-delay = <500>; /* milliseconds */
+	coefficients = <65 (-1791)>;
 };
 
 /include/ "omap54xx-clocks.dtsi"
+
+&gpu_thermal {
+	coefficients = <117 (-2992)>;
+};
+
+&core_thermal {
+	coefficients = <0 2000>;
+};
-- 
1.9.1
