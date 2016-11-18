From: robertcnelson@gmail.com (Robert Nelson)
Date: Thu, 17 Nov 2016 20:44:36 -0600
Subject: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
In-Reply-To: <20161118024436.13447-1-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Message-ID: <20161118024436.13447-6-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Julien <jboulnois@gmail.com>
CC: Nishanth Menon <nm@ti.com>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 6df7829..3bc47be 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -97,6 +97,12 @@
 		#cooling-cells = <2>;
 	};
 
+	gpu-subsystem {
+		compatible = "ti,gc320-gpu-subsystem";
+		cores = <&bb2d>;
+		status = "okay";
+	};
+
 	hdmi0: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -190,6 +196,11 @@
 		>;
 	};
 };
+
+&bb2d {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
2.10.2
