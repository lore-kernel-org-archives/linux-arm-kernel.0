From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 May 2014 19:03:57 +0530
Subject: [PATCH 11/17] ARM: dts: dra7xx-clocks: Add missing 32khz clocks used
 for PHY
In-Reply-To: <1399383244-14556-1-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
Message-ID: <1399383244-14556-12-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added missing 32khz clock used by PCIe PHY.
The documention for this node can be found @ ../bindings/clock/ti/gate.txt.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 44993ec..e1bd052 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1165,6 +1165,14 @@
 		reg = <0x021c>, <0x0220>;
 	};
 
+	optfclk_pciephy_32khz: optfclk_pciephy_32khz at 4a0093b0 {
+		compatible = "ti,gate-clock";
+		clocks = <&sys_32k_ck>;
+		#clock-cells = <0>;
+		reg = <0x13b0>;
+		ti,bit-shift = <8>;
+	};
+
 	optfclk_pciephy_div: optfclk_pciephy_div at 4a00821c {
 		compatible = "ti,divider-clock";
 		clocks = <&apll_pcie_ck>;
-- 
1.7.9.5
