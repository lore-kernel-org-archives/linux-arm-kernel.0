From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 Jan 2014 08:36:51 -0400
Subject: [PATCHv2 7/7] arm: dts: add thermal zones info on tmp102 for DRA7-EVM
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1389011811-13004-8-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple thermal zone on tmp102.

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
 arch/arm/boot/dts/dra7-evm.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 36e2c9e..1ea9c3d 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -95,6 +95,21 @@
 	};
 };
 
+&thermal_zones {
+	pcb_thermal: pcb_thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <1000>; /* milliseconds */
+		thermal-sensors = <&tmp102>;
+		trips {
+			crit at 80000 {
+			temperature = <80000>;
+				hysteresis = <1000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
 &i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.2.1.342.gfa7285d
