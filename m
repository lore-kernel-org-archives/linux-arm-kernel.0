From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:32 +0100
Subject: [PATCH v3 09/19] ARM: sun5i: Add TV encoder gate to the DTSI
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-10-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that the A13 / R8 also have a tve encoder block, and a gate
for it.

Add it to the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index d3d2b19c97f1..263d46dbc7e6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -111,8 +111,8 @@
 					<10>, <13>,
 					<14>, <20>,
 					<21>, <22>,
-				        <28>, <32>, <36>,
-				        <40>, <44>,
+					<28>, <32>, <34>,
+					<36>, <40>, <44>,
 					<46>, <51>,
 					<52>;
 			clock-output-names = "ahb_usbotg", "ahb_ehci",
@@ -121,8 +121,8 @@
 					     "ahb_mmc2", "ahb_nand",
 					     "ahb_sdram", "ahb_spi0",
 					     "ahb_spi1", "ahb_spi2",
-					     "ahb_stimer", "ahb_ve", "ahb_lcd",
-					     "ahb_csi", "ahb_de_be",
+					     "ahb_stimer", "ahb_ve", "ahb_tve",
+					     "ahb_lcd", "ahb_csi", "ahb_de_be",
 					     "ahb_de_fe", "ahb_iep",
 					     "ahb_mali400";
 		};
-- 
2.7.3
