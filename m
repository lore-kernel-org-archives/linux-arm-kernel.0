From: briannorris@chromium.org (Brian Norris)
Date: Mon, 20 Mar 2017 16:53:44 -0700
Subject: [PATCH v3 4/4] arm64: dts: rockchip: add regulator info for Kevin
 digitizer
In-Reply-To: <20170320235344.126298-1-briannorris@chromium.org>
References: <20170320235344.126298-1-briannorris@chromium.org>
Message-ID: <20170320235344.126298-5-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to enable this regulator before the digitizer can be used. Wacom
recommended waiting for 100 ms before talking to the HID.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v3:
 * reintroduced into patch set; bindings are in linux-next
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 2f720cf2fd07..f4714c4606f3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -232,6 +232,9 @@ ap_i2c_dig: &i2c2 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&cpu1_dig_irq_l &cpu1_dig_pdct_l>;
 
+		vdd-supply = <&p3_3v_dig>;
+		post-power-on-delay-ms = <100>;
+
 		interrupt-parent = <&gpio2>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 
-- 
2.12.0.367.g23dc2f6d3c-goog
