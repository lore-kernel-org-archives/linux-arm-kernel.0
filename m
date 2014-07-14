From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 14 Jul 2014 16:12:16 +0530
Subject: [RESEND PATCH 1/8] ARM: dts: dra7xx-clocks: Add divider table to
 optfclk_pciephy_div clock
In-Reply-To: <1405334543-25509-1-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Message-ID: <1405334543-25509-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

Add divider table to optfclk_pciephy_div clock. The 8th bit of
CM_CLKMODE_APLL_PCIE can be programmed to either 0x0 or 0x1
based on if the divider value is 0x2 or 0x1.

Figure 26-21. PCIe PHY Clock Generator Overview in vE of DRA7xx ES1.0 shows the
block diagram of Clock Generator Subsystem of PCIe PHY module. The divider
value if '1' should be programmed in order to get the correct
PCIE_PHY_DIV_GCLK frequency (2.5GHz).

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index b03cfe4..7148e7c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1170,6 +1170,7 @@
 		clocks = <&apll_pcie_ck>;
 		#clock-cells = <0>;
 		reg = <0x021c>;
+		ti,dividers = <2>, <1>;
 		ti,bit-shift = <8>;
 		ti,max-div = <2>;
 	};
-- 
1.7.9.5
