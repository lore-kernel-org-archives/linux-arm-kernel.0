From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 19:10:50 +0530
Subject: [PATCH 10/14] ARM: dts: dra71-evm: Correct evm_sd regulator max
 voltage
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Message-ID: <20171214134054.7749-11-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravikumar Kattekola <rk@ti.com>

Correct vpo_sd_1v8_3v3 regulator max voltage to 3.3V

Fixes: 9868bc585ae2 ("ARM: dts: Add support for dra718-evm")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 41c9132eb550..64363f75c01a 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -24,13 +24,13 @@
 
 		regulator-name = "vddshv8";
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&evm_5v0>;
 
 		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0
-			  3000000 0x1>;
+			  3300000 0x1>;
 	};
 
 	evm_1v8_sw: fixedregulator-evm_1v8 {
-- 
2.11.0
