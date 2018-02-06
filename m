From: seanpaul@chromium.org (Sean Paul)
Date: Tue,  6 Feb 2018 11:56:22 -0500
Subject: [PATCH 3/3] arm64: dts: rockchip: Specify override mode for kevin
 panel
In-Reply-To: <20180206165626.37692-1-seanpaul@chromium.org>
References: <20180206165626.37692-1-seanpaul@chromium.org>
Message-ID: <20180206165626.37692-4-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an override mode for kevin devices. The mode increases
both back porches to allow a pixel clock of 26666kHz as opposed to the
'typical' value of 252750kHz. This is needed to avoid interference with
the touch digitizer on these laptops.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: St?phane Marchesin <marcheu@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 191a6bcb1704..24430e689bcf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -98,6 +98,20 @@
 		backlight = <&backlight>;
 		power-supply = <&pp3300_disp>;
 
+		override-mode {
+			clock-frequency = <266604720>;
+			hactive = <2400>;
+			hfront-porch = <48>;
+			hback-porch = <84>;
+			hsync-len = <32>;
+			hsync-active = <0>;
+			vactive = <1600>;
+			vfront-porch = <3>;
+			vback-porch = <120>;
+			vsync-len = <10>;
+			vsync-active = <0>;
+		};
+
 		ports {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
-- 
2.16.0.rc1.238.g530d649a79-goog
