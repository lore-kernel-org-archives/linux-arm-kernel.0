From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 20 May 2016 13:13:33 +0300
Subject: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
Message-ID: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi
file. Video PLL2 has not been used so wrong addresses went unnoticed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 4220eeffc65a..5e06020f450b 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -107,8 +107,8 @@
 	reg = <0x58000000 0x80>,
 	      <0x58004054 0x4>,
 	      <0x58004300 0x20>,
-	      <0x58005054 0x4>,
-	      <0x58005300 0x20>;
+	      <0x58009054 0x4>,
+	      <0x58009300 0x20>;
 	reg-names = "dss", "pll1_clkctrl", "pll1",
 		    "pll2_clkctrl", "pll2";
 
-- 
2.5.0
