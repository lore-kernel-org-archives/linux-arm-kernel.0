From: john@metanate.com (John Keeping)
Date: Tue, 23 Feb 2016 12:39:41 +0000
Subject: [PATCH] ARM: dts: rockchip: add mipi_dsi to VIO power domain on rk3288
Message-ID: <1456231181-13989-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI controllers are part of the VIO power domain so add the
necessary property to indicate this for the controller we support.

Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d879a89..a92a3b5 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -890,6 +890,7 @@
 		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
 		clock-names = "ref", "pclk";
 		rockchip,grf = <&grf>;
+		power-domains = <&power RK3288_PD_VIO>;
 		status = "disabled";
 
 		ports {
-- 
2.7.0.226.gfe986fe
