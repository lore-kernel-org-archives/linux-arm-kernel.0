From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 1 Jun 2015 09:23:11 +0300
Subject: [PATCHv4 03/10] arm/dts: dra7xx: add 'ti,
 set-rate-parent' for dss_dss_clk
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1433139798-23450-4-git-send-email-tomi.valkeinen@ti.com>
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
index 470f39c4e326..357bedeebfac 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1531,6 +1531,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1120>;
+		ti,set-rate-parent;
 	};
 
 	dss_hdmi_clk: dss_hdmi_clk {
-- 
2.1.4
