From: j-keerthy@ti.com (Keerthy)
Date: Wed, 1 Mar 2017 15:59:45 +0530
Subject: [PATCH 2/7] ARM: OMAP5: Thermal: Add slope and offset values
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1488364190-23488-3-git-send-email-j-keerthy@ti.com>
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
