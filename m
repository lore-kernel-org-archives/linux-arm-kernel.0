From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:24 +0200
Subject: [PATCH v4 26/28] ARM: dts: s500: Set power domains for CPU2 and CPU3
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-27-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU2 has its own power domain PD_CPU2, and CPU3 has PD_CPU3.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v4: new (split off due to dt-bindings dependency)
 
 arch/arm/boot/dts/s500.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
index 51a48741d4c0..4e4478a3ec08 100644
--- a/arch/arm/boot/dts/s500.dtsi
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/s500-powergate.h>
 
 / {
 	compatible = "actions,s500";
@@ -43,6 +44,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0x2>;
 			enable-method = "actions,s500-smp";
+			power-domains = <&sps S500_PD_CPU2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -50,6 +52,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0x3>;
 			enable-method = "actions,s500-smp";
+			power-domains = <&sps S500_PD_CPU3>;
 		};
 	};
 
-- 
2.12.3
