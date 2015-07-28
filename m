From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:04:04 +0000
Subject: [PATCH 10/10] ARM: dts: atlas7: add a GPIO key for rearview button
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-11-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Sun <Andy.Sun@csr.com>

Touching this key will trigger a camera event for rearview.

Signed-off-by: Andy Sun <Andy.Sun@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7-evb.dts b/arch/arm/boot/dts/atlas7-evb.dts
index 49cf59a..1e9cd1a 100644
--- a/arch/arm/boot/dts/atlas7-evb.dts
+++ b/arch/arm/boot/dts/atlas7-evb.dts
@@ -10,6 +10,9 @@
 
 /include/ "atlas7.dtsi"
 
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "CSR SiRFatlas7 Evaluation Board";
 	compatible = "sirf,atlas7-cb", "sirf,atlas7";
@@ -106,5 +109,20 @@
 				};
 			};
 		};
+
+		gpio_keys {
+			compatible = "gpio-keys";
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rearview_key {
+				label = "rearview key";
+				linux,code = <KEY_CAMERA>;
+				gpios = <&gpio_1 3 GPIO_ACTIVE_LOW>;
+				debounce_interval = <100>;
+			};
+		};
+
 	};
 };
-- 
1.9.1
