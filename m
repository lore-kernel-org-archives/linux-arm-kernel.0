From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:20 -0600
Subject: [PATCH 2/8] ARM: dts: dra7: Add MPU OPP supply node
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the OPP supply node for the MPU voltage rail to provide the
information needed by the ti-opp-supply driver to enable AVS Class 0.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9f60144793b..33004e7f1ee9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -2057,6 +2057,19 @@
 			clocks = <&l3_iclk_div>;
 			clock-names = "fck";
 		};
+
+		opp_supply_mpu: opp-supply at 4a003b20 {
+			compatible = "ti,omap5-opp-supply";
+			reg = <0x4a003b20 0xc>;
+			ti,efuse-settings = <
+			/* uV   offset */
+			1060000 0x0
+			1160000 0x4
+			1210000 0x8
+			>;
+			ti,absolute-max-voltage-uv = <1500000>;
+		};
+
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.15.1
