From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed, 17 May 2017 17:52:26 +0800
Subject: [PATCH v2 3/3] arm: dts: rk322x: add watchdog device node.
In-Reply-To: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
References: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495014746-27621-4-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog device node for rk322x SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index fe6530f..f7498b3 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -280,6 +280,14 @@
 		status = "disabled";
 	};
 
+	wdt: watchdog at 110a0000 {
+		compatible = "snps,dw-wdt";
+		reg = <0x110a0000 0x100>;
+		clocks = <&cru PCLK_CPU>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pwm0: pwm at 110b0000 {
 		compatible = "rockchip,rk3288-pwm";
 		reg = <0x110b0000 0x10>;
-- 
2.0.0
