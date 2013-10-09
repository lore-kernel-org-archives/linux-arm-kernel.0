From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Oct 2013 18:24:53 -0500
Subject: [PATCH V6 10/15] ARM: dts: DRA7: Add CPU OPP table
In-Reply-To: <1381361098-8283-1-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com>
Message-ID: <1381361098-8283-9-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: J Keerthy <j-keerthy@ti.com>

Add DT OPP table for DRA7xx family of devices. This data is decoded by
OF with of_init_opp_table() helper function.

The data is based on DRA75x, DRA74x Data Manual revision F (Sept 2013).

TODO: add OPP_HIGH after AVS-Class0 is functional
NOTE: The voltage and frequency values work well only on NOM samples
and it is mandatory to use ABB/AVS Class 0 support for all OPPs.

Clock nodes are pending clock node alignment.

[nm at ti.com: cleanups and rebase to latest]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 02e430b..92cbe3b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -36,6 +36,12 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			operating-points = <
+				/* kHz    uV */
+				1000000	1060000
+				1176000	1160000
+				>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.7.9.5
