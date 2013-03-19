From: nm@ti.com (Nishanth Menon)
Date: Tue, 19 Mar 2013 12:53:08 -0500
Subject: [PATCH V2 6/8] ARM: dts: OMAP4460: Add CPU OPP table
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Message-ID: <1363715590-5131-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT OPP table for OMAP4460 family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

OPP data here is based on existing opp4xxx_data.c

This is in preparation to use generic cpufreq-cpu0 driver for device
tree enabled boot. Legacy non device tree enabled boot continues to
use omap-cpufreq.c and opp4xxx_data.c.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: cpufreq at vger.kernel.org
Cc: linux-pm at vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V2:
	- depend on 4460.dtsi available in benoit/for_3.10/dts branch
	- donot delete the OPP table entries in omap4xxx_data.c
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273611/

 arch/arm/boot/dts/omap4460.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index e09b3e1..7c2c23c 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -10,6 +10,19 @@
 /include/ "omap4.dtsi"
 
 / {
+	cpus {
+		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
+		cpu at 0 {
+			operating-points = <
+				/* kHz    uV */
+				350000   975000
+				700000  1075000
+				920000  1200000
+			>;
+			clock-latency = <300000>; /* From legacy driver */
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 54 0x4>,
-- 
1.7.9.5
