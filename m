From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 14 Feb 2018 17:58:30 +0200
Subject: [PATCH] ARM: dts: Keystone: add ECC error handler support
Message-ID: <1518623910-24700-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Add emif node for keystone2 devices, which is used for ECC support.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
[t-kristo at ti.com: made emif enabled by default for all keystone2 devices]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
Depends on the dt-binding, which has been posted here:
- https://www.spinics.net/lists/devicetree/msg214633.html

 arch/arm/boot/dts/keystone-k2g.dtsi | 6 ++++++
 arch/arm/boot/dts/keystone.dtsi     | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index ca94221..9c50b76 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -590,5 +590,11 @@
 			power-domains = <&k2g_pds 0x22>;
 			clocks = <&k2g_clks 0x22 0>;
                 };
+
+		emif: emif at 21010000 {
+			compatible = "ti,emif-keystone";
+			reg = <0x21010000 0x200>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 93ea5c6..41339bd 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -338,5 +338,12 @@
 					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
+
+		emif: emif at 21010000 {
+			compatible = "ti,emif-keystone";
+			reg = <0x21010000 0x200>;
+			interrupts = <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>;
+			interrupt-parent = <&gic>;
+		};
 	};
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
