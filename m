From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Mar 2015 16:35:56 -0800
Subject: [PATCH v5 8/8] ARM: dts: cygnus: enable GPIO based hook detection
In-Reply-To: <1425515756-321-1-git-send-email-rjui@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425515756-321-9-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables GPIO based phone hook detection for Broadcom BCM911360
phone factor board (bcm911360_entphn)

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 arch/arm/boot/dts/bcm911360_entphn.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index d2ee952..7db4843 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -33,6 +33,7 @@
 /dts-v1/;
 
 #include "bcm-cygnus.dtsi"
+#include "dt-bindings/input/input.h"
 
 / {
 	model = "Cygnus Enterprise Phone (BCM911360_ENTPHN)";
@@ -50,4 +51,16 @@
 	uart3: serial at 18023000 {
 		status = "okay";
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hook {
+			label = "HOOK";
+			linux,code = <KEY_O>;
+			gpios = <&gpio_asiu 48 0>;
+		};
+	};
 };
-- 
1.7.9.5
