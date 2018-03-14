From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Mar 2018 15:53:14 +0200
Subject: [PATCH v2 5/6] ARM: dts: omap5: add fref_xtal_ck support
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Message-ID: <20180314135315.11215-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

The clock is directly sourced from sys_clkin, and provides an external
output clock for (typically) TWL6040 chip.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 9619a746d657..ecc5573d264c 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -1179,3 +1179,13 @@
 		};
 	};
 };
+
+&scm_wkup_pad_conf_clocks {
+	fref_xtal_ck: fref_xtal_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin>;
+		ti,bit-shift = <28>;
+		reg = <0x14>;
+	};
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
