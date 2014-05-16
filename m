From: nm@ti.com (Nishanth Menon)
Date: Fri, 16 May 2014 05:46:00 -0500
Subject: [PATCH 3/3] ARM: dts: OMAP5/DRA7: use omap5-mpu-dpll-clock capable of
 dealing with higher frequencies
In-Reply-To: <1400237160-25125-1-git-send-email-nm@ti.com>
References: <1400237160-25125-1-git-send-email-nm@ti.com>
Message-ID: <1400237160-25125-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5432, DRA75x and DRA72x have MPU DPLLs that need Duty Cycle
Correction(DCC) to operate safely at frequencies >= 1.4GHz.

Switch to "ti,omap5-mpu-dpll-clock" compatible property which provides
this support.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi   |    2 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cfb8fc7..aac5522 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -277,7 +277,7 @@
 
 	dpll_mpu_ck: dpll_mpu_ck {
 		#clock-cells = <0>;
-		compatible = "ti,omap4-dpll-clock";
+		compatible = "ti,omap5-mpu-dpll-clock";
 		clocks = <&sys_clkin1>, <&mpu_dpll_hs_clk_div>;
 		reg = <0x0160>, <0x0164>, <0x016c>, <0x0168>;
 	};
diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index d487fda..465505c 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -362,7 +362,7 @@
 
 	dpll_mpu_ck: dpll_mpu_ck {
 		#clock-cells = <0>;
-		compatible = "ti,omap4-dpll-clock";
+		compatible = "ti,omap5-mpu-dpll-clock";
 		clocks = <&sys_clkin>, <&mpu_dpll_hs_clk_div>;
 		reg = <0x0160>, <0x0164>, <0x016c>, <0x0168>;
 	};
-- 
1.7.9.5
