From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:35 +0100
Subject: [PATCH 2/7] ARM: dts: STiH410: Add thermal node
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160815121740.29515-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
[Lee: Changed node name and added the unit address]
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 18ed1ad..7590721 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -227,5 +227,13 @@
 			clock-names = "bdisp";
 			clocks = <&clk_s_c0_flexgen CLK_IC_BDISP_0>;
 		};
+
+		thermal at 91a0000 {
+			compatible = "st,stih407-thermal";
+			reg = <0x91a0000 0x28>;
+			clock-names = "thermal";
+			clocks = <&clk_sysin>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
-- 
2.9.0
