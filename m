From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:14:58 +0800
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add the needed timer for RK3368
 SoC
In-Reply-To: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1443147298-12603-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a need of a broadcast timer in this case to ensure proper
wakeup when the cpus are in sleep mode and a timer expires.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None
Changes in v1:
- As the Heiko comments, add the "rockchip,rk3368-timer" for timer.
  Although the 'rockchip,rk3288-timer' is working for RK3368, need to add the
  'rockchip,rk3368-timer' for the rk3368-spec timer in the future.

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a712bea..c4b3870 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -214,6 +214,12 @@
 			(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	timer at ff810000 {
+		compatible = "rockchip,rk3368-timer", "rockchip,rk3288-timer";
+		reg = <0x0 0xff810000 0x0 0x20>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	xin24m: oscillator {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
1.9.1
