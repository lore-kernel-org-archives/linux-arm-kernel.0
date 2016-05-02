From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Mon, 2 May 2016 12:12:03 -0500
Subject: [PATCH v2 3/3] ARM: dts: dra7: fix clock node definition to avoid
 build warning
In-Reply-To: <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
Message-ID: <1462209123-7332-4-git-send-email-Linux.HWI@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This patch fixes the following warning for the DRA7 clock node:
Warning (unit_address_vs_reg): Node
/ocp/l4 at 4a000000/scm at 2000/scm_conf at 0/clocks/sys_32k_ck
has a reg or ranges property, but no unit name

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index f7ec976..34cda4b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2186,7 +2186,7 @@
 		reg = <0x0558>;
 	};
 
-	sys_32k_ck: sys_32k_ck {
+	sys_32k_ck: sys_32k_ck at 6c4 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clk32_crystal_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>;
-- 
1.9.1
