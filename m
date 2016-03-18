From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:39:57 +0100
Subject: [PATCH 01/10] ARM: dts: rockchip: add rk3288 edp-phy node
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core device node of the edp-phy on rk3288 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 0934b6a..d6af337 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -201,6 +201,15 @@
 		#clock-cells = <0>;
 	};
 
+	edp_phy: edp-phy {
+		compatible = "rockchip,rk3288-dp-phy";
+		clocks = <&cru SCLK_EDP_24M>;
+		clock-names = "24m";
+		rockchip,grf = <&grf>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		arm,cpu-registers-not-fw-configured;
-- 
2.6.4
