From: vigneshr@ti.com (Vignesh R)
Date: Wed, 24 Aug 2016 13:28:59 +0530
Subject: [PATCH v3 2/2] ARM: dts: am335x-icev2: Add nodes for gpio-decoder
In-Reply-To: <20160824075859.30979-1-vigneshr@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
Message-ID: <20160824075859.30979-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x ICE board has a rotary-switch connected to PCA9536 I2C GPIO
expander. The position of the rotary-switch is reflected by status of
GPIO lines. Add gpio-decoder node to read these GPIO line status via
gpio-decoder driver and report it as an input event to the system.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3: s/decoder,max-value/decoder-max-value

 arch/arm/boot/dts/am335x-icev2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index bc0190e4f10f..426022ee85c7 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -139,6 +139,15 @@
 			default-state = "off";
 		};
 	};
+	gpio-decoder {
+		compatible = "gpio-decoder";
+		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
+			<&pca9536 2 GPIO_ACTIVE_HIGH>,
+			<&pca9536 1 GPIO_ACTIVE_HIGH>,
+			<&pca9536 0 GPIO_ACTIVE_HIGH>;
+		linux,axis = <0>; /* ABS_X */
+		decoder-max-value = <9>;
+	};
 };
 
 &am33xx_pinmux {
-- 
2.9.2
