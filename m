From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  7 Sep 2018 15:22:34 +0800
Subject: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback compatible
 from R40 DT
In-Reply-To: <20180907072234.48282-1-icenowy@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
Message-ID: <20180907072234.48282-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R40 HDMI PHY seems to be different to the A64 one, the A64 one
has no input mux, but the R40 one has.

Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index ffd9f00f74a4..5f547c161baf 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -800,8 +800,7 @@
 		};
 
 		hdmi_phy: hdmi-phy at 1ef0000 {
-			compatible = "allwinner,sun8i-r40-hdmi-phy",
-				     "allwinner,sun50i-a64-hdmi-phy";
+			compatible = "allwinner,sun8i-r40-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
 				 <&ccu 7>, <&ccu 16>;
-- 
2.18.0
