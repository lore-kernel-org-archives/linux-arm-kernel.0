From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 14 Jul 2014 16:12:18 +0530
Subject: [RESEND PATCH 3/8] ARM: dts: dra7xx-clocks: Add missing 32KHz clocks
 used for PHY
In-Reply-To: <1405334543-25509-1-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Message-ID: <1405334543-25509-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added missing 32KHz clock used by PCIe PHY.
Figure 26-19. PCIe PHY Subsystem Integration in vE of DRA7xx ES1.0 TRM shows
32KHz is used by PCIe PHY.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index f5dca1f..3ff6d7c 100644
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
