From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  7 Jun 2016 12:54:33 +0800
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add rktimer device node for
 rk3399
In-Reply-To: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
References: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1465275273-22076-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

Select rktimer0 as broadcast timer.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianqun Xu <jay.xu@rock-chips.com>

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- %s/ARM64/arm64.

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d331e80..f0d1935 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -542,6 +542,14 @@
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
