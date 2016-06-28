From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:27 +0200
Subject: [PATCH 08/92] arm64: dts: rockchip: Add rktimer device node for rk3399
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

Add a 'rktimer' node in the device treee for the ARM64 rk3399 SoC.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a..f0c0d76 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -492,6 +492,14 @@
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rktimer: rktimer at ff850000 {
+		compatible = "rockchip,rk3399-timer";
+		reg = <0x0 0xff850000 0x0 0x1000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_TIMER0>, <&cru SCLK_TIMER00>;
+		clock-names = "pclk", "timer";
+	};
+
 	spdif: spdif at ff870000 {
 		compatible = "rockchip,rk3399-spdif";
 		reg = <0x0 0xff870000 0x0 0x1000>;
-- 
1.9.1
