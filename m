From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 16 Oct 2017 17:46:22 +0530
Subject: [PATCH 4/9] ARM: dts: rockchip: Add regulators for rk3288-vyasa
In-Reply-To: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1508156187-27519-5-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add supporting regulators for rk3288-vyasa board, dc12_vbat is
parent regulatorand followed regulators as are child regulators.
regulator naming conversion followed as per schematic for better
readability and easy for identification.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index c14ebf9..0fa447f 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -56,13 +56,53 @@
 		device_type = "memory";
 	};
 
+	dc12_vbat: dc12-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "dc12_vbat";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vboot_3v3: vboot-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vboot_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&dc12_vbat>;
+	};
+
 	vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&dc12_vbat>;
+	};
+
+	vboot_5v: vboot-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vboot_sv";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 		regulator-boot-on;
+		vin-supply = <&dc12_vbat>;
+	};
+
+	v3g_3v3: v3g-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3g_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&dc12_vbat>;
 	};
 };
 
-- 
2.7.4
