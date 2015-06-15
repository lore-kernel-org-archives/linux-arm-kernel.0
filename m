From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 15 Jun 2015 17:41:41 +0000
Subject: [PATCH] ARM: dts: rockchip: Add ramp delay for vdd_cpu in firefly
 board dts
Message-ID: <1434390101-27000-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds ramp delay for the vdd_cpu output. It removes warning "ramp_delay not set"
emitted by the function regulator_set_voltage_time_sel() by the same time,
which floods kernel logs.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0b42372..0c66e92 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -213,6 +213,8 @@
 		regulator-max-microvolt = <1350000>;
 		regulator-always-on;
 		regulator-boot-on;
+		regulator-enable-ramp-delay = <300>;
+		regulator-ramp-delay = <8000>;
 		vin-supply = <&vcc_sys>;
 	};
 
-- 
1.9.1
