From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 Jan 2014 08:36:49 -0400
Subject: [PATCHv2 5/7] arm: dts: dra7: add thermal data
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1389011811-13004-6-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds thermal data for DRA7 SoCs. Cpufreq cooling
will be enabled for MPU domain whenever it crosses 100C.
GPU, CORE, DSPEVE, IVA will be exposed and system shall
shutdown when they cross 125C.

Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 139472c..4784c0c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -68,6 +68,15 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	thermal_zones: thermal-zones {
+		/* SoC thermal zones */
+		#include "omap4-cpu-thermal.dtsi"
+		#include "omap5-gpu-thermal.dtsi"
+		#include "omap5-core-thermal.dtsi"
+		#include "dra7-dspeve-thermal.dtsi"
+		#include "dra7-iva-thermal.dtsi"
+	};
+
 	gic: interrupt-controller at 48211000 {
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
-- 
1.8.2.1.342.gfa7285d
