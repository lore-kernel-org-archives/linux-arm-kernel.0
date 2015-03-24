From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 24 Mar 2015 16:55:01 +0200
Subject: [PATCHv2 01/10] arm/dts: dra7xx: add 'ti,
 set-rate-parent' for dss_dss_clk
In-Reply-To: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1427208910-17678-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need set-rate-parent flags for the display's clock path so that the
DSS driver can change the clock rate of the PLL.

This patchs adds the ti,set-rate-parent flag to 'dss_dss_clk' clock
node, which is only a gate clock, allowing the setting of the clock rate
to propagate to the PLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 4bdcbd61ce47..0d76233840e6 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1451,6 +1451,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1120>;
+		ti,set-rate-parent;
 	};
 
 	dss_hdmi_clk: dss_hdmi_clk {
-- 
2.3.3
