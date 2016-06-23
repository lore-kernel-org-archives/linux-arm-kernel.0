From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:21:00 +0200
Subject: [PATCH 10/14] ARM: dts: sun8i: Add sy8106a regulator to Orange Pi PC
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-11-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Add sy8106a regulator to r_twi bus on Orange Pi PC. This
regulator controls the CPUX voltage.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index e5991da..7e04017 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -92,6 +92,16 @@
 
 &r_twi {
 	status = "okay";
+
+	vdd_cpu: regulator at 65 {
+		compatible = "sy8106a";
+		reg = <0x65>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <200>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &ehci1 {
-- 
2.9.0
