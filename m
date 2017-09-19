From: vigneshr@ti.com (Vignesh R)
Date: Tue, 19 Sep 2017 11:45:49 +0530
Subject: [RESEND PATCH 1/3] ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
In-Reply-To: <20170919061551.11981-1-vigneshr@ti.com>
References: <20170919061551.11981-1-vigneshr@ti.com>
Message-ID: <20170919061551.11981-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for PWM ECAP IP present on 66AK2G SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 826b286665e6..dace4672b1e6 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -343,5 +343,25 @@
 			clock-names = "fck", "mmchsdb_fck";
 			status = "disabled";
 		};
+
+		ecap0: pwm at 21d1800 {
+			compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+			#pwm-cells = <3>;
+			reg = <0x021d1800 0x60>;
+			power-domains = <&k2g_pds 0x38>;
+			clocks = <&k2g_clks 0x38 0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
+		ecap1: pwm at 21d1c00 {
+			compatible = "ti,k2g-ecap", "ti,am3352-ecap";
+			#pwm-cells = <3>;
+			reg = <0x021d1c00 0x60>;
+			power-domains = <&k2g_pds 0x39>;
+			clocks = <&k2g_clks 0x39 0x0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
 	};
 };
-- 
2.14.1
