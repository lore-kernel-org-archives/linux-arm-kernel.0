From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:15:15 +0100
Subject: [PATCH v3 3/4] ARM: dts: da850-evm: add the UI expander node
In-Reply-To: <1488298516-14363-1-git-send-email-bgolaszewski@baylibre.com>
References: <1488298516-14363-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1488298516-14363-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need the expander to be probed to allow the VPIF controller to
receive interrupts from the video decoder.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index dece981..3968a18 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -9,6 +9,7 @@
  */
 /dts-v1/;
 #include "da850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "ti,da850-evm", "ti,da850";
@@ -78,7 +79,10 @@
 				DRVDD-supply = <&vbat>;
 				DVDD-supply = <&vbat>;
 			};
-
+			tca6416: gpio at 20 {
+				compatible = "ti,tca6416";
+				reg = <0x20>;
+			};
 		};
 		wdt: wdt at 21000 {
 			status = "okay";
-- 
2.9.3
