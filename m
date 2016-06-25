From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:08 +0200
Subject: [PATCH v2 11/14] ARM: dts: sun8i: Add sy8106a regulator to Orange Pi
 PC
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-12-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Add sy8106a regulator to r_twi bus and enable the r_twi bus on
Orange Pi PC. This regulator controls the CPUX voltage.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9a6..79f0b49 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -90,6 +90,20 @@
 	};
 };
 
+&r_twi {
+	status = "okay";
+
+	vdd_cpu: regulator at 65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <200>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.9.0
