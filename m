From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:39:59 +0100
Subject: [PATCH 03/10] ARM: dts: rockchip: move edp-hpd pin definition into
 common location
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edp hotplug pin is fixed on the soc side, anybody wanting to use it
will need the same definition anyway, so move it to a common location.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-jaq.dts | 6 ------
 arch/arm/boot/dts/rk3288.dtsi           | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index c2f52cf..5c97e31 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -142,12 +142,6 @@
 		};
 	};
 
-	edp {
-		edp_hpd: edp_hpd {
-			rockchip,pins = <7 11 RK_FUNC_2 &pcfg_pull_down>;
-		};
-	};
-
 	hdmi {
 		vcc50_hdmi_en: vcc50-hdmi-en {
 			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26cdcee..f11a28f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1211,6 +1211,12 @@
 			};
 		};
 
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins = <7 11 RK_FUNC_2 &pcfg_pull_down>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
-- 
2.6.4
