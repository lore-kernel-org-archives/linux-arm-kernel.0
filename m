From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:34 +0100
Subject: [PATCH v3 24/25] ARM: dts: s500: Add SPS node
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-25-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: new
 
 arch/arm/boot/dts/s500.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
index b4ebd27..e802896 100644
--- a/arch/arm/boot/dts/s500.dtsi
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -9,6 +9,7 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/s500-powergate.h>
 
 / {
 	compatible = "actions,s500";
@@ -37,6 +38,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0x2>;
 			enable-method = "actions,s500-smp";
+			power-domains = <&sps S500_PD_CPU2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -44,6 +46,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0x3>;
 			enable-method = "actions,s500-smp";
+			power-domains = <&sps S500_PD_CPU3>;
 		};
 	};
 
@@ -170,5 +173,11 @@
 			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "2Hz0", "2Hz1", "Timer0", "Timer1";
 		};
+
+		sps: power-controller at b01b0100 {
+			compatible = "actions,s500-sps";
+			reg = <0xb01b0100 0x100>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
-- 
2.10.2
