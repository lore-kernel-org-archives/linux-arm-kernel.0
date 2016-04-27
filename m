From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:20:28 +1000
Subject: [PATCH 01/10] ARM: dts: r8a7779: Add SYSC PM Domains
In-Reply-To: <cover.1461730638.git.horms+renesas@verge.net.au>
References: <cover.1461730638.git.horms+renesas@verge.net.au>
Message-ID: <b2df3aa487395a1b7170b719569769bc78939dd1.1461730638.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller.
Hook up ARM CPU cores 1-3 to their respective PM Domains.
Note that ARM CPU core 0 cannot be shut off.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c1d48d712a1..e02875a8c040 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7779-sysc.h>
 
 / {
 	compatible = "renesas,r8a7779";
@@ -34,18 +35,21 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM1>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM2>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7779_PD_ARM3>;
 		};
 	};
 
@@ -586,4 +590,10 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller at ffd85000 {
+		compatible = "renesas,r8a7779-sysc";
+		reg = <0xffd85000 0x0200>;
+		#power-domain-cells = <1>;
+	};
 };
-- 
2.7.0.rc3.207.g0ac5344
