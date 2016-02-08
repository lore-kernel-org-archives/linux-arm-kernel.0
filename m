From: j-keerthy@ti.com (Keerthy)
Date: Mon, 8 Feb 2016 15:15:05 +0530
Subject: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Message-ID: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal threholds for am57xx are different from that of dra7.
Correcting the thresholds for the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Depends on: https://lkml.org/lkml/2016/2/8/90

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
===================================================================
--- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.514959101 +0530
+++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts	2016-02-08 14:57:05.510959168 +0530
@@ -825,3 +825,27 @@
 		status = "okay";
 	};
 };
+
+&cpu_alert0 {
+	temperature = <90000>; /* milliCelsius */
+};
+
+&cpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&gpu_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&core_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&dspeve_crit {
+	temperature = <105000>; /* milliCelsius */
+};
+
+&iva_crit {
+	temperature = <105000>; /* milliCelsius */
+};
