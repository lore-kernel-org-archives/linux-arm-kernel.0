From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 22 Jun 2016 16:23:51 +0300
Subject: [PATCHv2 18/27] ARM: dts: DRA7: Add DT node for RNG IP
In-Reply-To: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
Message-ID: <1466601840-18486-19-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Adding dt node for hardware random number generator IP.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 64759e1..16ff083 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1787,6 +1787,15 @@
 			clocks = <&l3_iclk_div>;
 			clock-names = "fck";
 		};
+
+		rng: rng at 48090000 {
+			compatible = "ti,omap4-rng";
+			ti,hwmods = "rng";
+			reg = <0x48090000 0x2000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
1.9.1
