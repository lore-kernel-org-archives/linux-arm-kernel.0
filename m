From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Sep 2015 15:26:37 +0200
Subject: [PATCH 4/4] ARM: sun8i: A23: Add missing msgbox gate
In-Reply-To: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1441977997-29041-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though it's not mentionned in the A23 user manual, the A23 has a gate
for the AHB1 clock to the msgbox IP. Add it to the clock-indices.

Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 4a85e213843b..92e6616979ea 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -62,8 +62,8 @@
 					<21>, <24>, <26>,
 					<29>, <32>, <36>,
 					<40>, <44>, <46>,
-					<52>, <54>,
-					<57>;
+					<52>, <53>,
+					<54>, <57>;
 			clock-output-names = "ahb1_mipidsi", "ahb1_dma",
 					"ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
 					"ahb1_nand", "ahb1_sdram",
@@ -71,8 +71,8 @@
 					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
 					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
 					"ahb1_csi", "ahb1_be",	"ahb1_fe",
-					"ahb1_gpu", "ahb1_spinlock",
-					"ahb1_drc";
+					"ahb1_gpu", "ahb1_msgbox",
+					"ahb1_spinlock", "ahb1_drc";
 		};
 
 		mbus_clk: clk at 01c2015c {
-- 
2.5.1
