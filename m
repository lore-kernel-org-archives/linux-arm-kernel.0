From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  4 Nov 2015 22:44:13 +0100
Subject: [PATCH 7/8] ARM: dts: rockchip: assign usbphy480m_src to the new
 usbphy pll on veyron
In-Reply-To: <1446673454-9529-1-git-send-email-heiko@sntech.de>
References: <1446673454-9529-1-git-send-email-heiko@sntech.de>
Message-ID: <1446673454-9529-8-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Veyron devices try to always set the source for usbphy480m to the usbphy0
that is the phy connected to the otg controller, because the firmware-
default is usbphy1, the ehci-controller connected to the internal camera
that might get turned off way easier to save power.

In the mainline kernel we currently don't use the usbphy480m_src at all,
as it mainly powers the uart0 source that is connected to the bluetooth
component of the wifi/bt combo.

So move that assignment over to the new real pll clock inside the usbphy.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index d4263ed..c8329b5 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -410,7 +410,7 @@
 	status = "okay";
 
 	assigned-clocks = <&cru SCLK_USBPHY480M_SRC>;
-	assigned-clock-parents = <&cru SCLK_OTGPHY0>;
+	assigned-clock-parents = <&usbphy0>;
 	dr_mode = "host";
 };
 
-- 
2.6.2
