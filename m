From: andy.yan@rock-chips.com (Andy Yan)
Date: Fri, 11 Aug 2017 11:45:33 +0800
Subject: [PATCH v3 08/13] ARM: dts: rockchip: add watchdog dt node for rv1108
In-Reply-To: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1502423133-31097-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog device tree node for rv1108

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rv1108.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 76a325a..75a0b1e 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -266,6 +266,15 @@
 		reg = <0x10300000 0x1000>;
 	};
 
+	watchdog: wdt at 10360000 {
+		compatible = "snps,dw-wdt";
+		reg = <0x10360000 0x100>;
+		clocks = <&cru PCLK_WDT>;
+		clock-names = "pclk_wdt";
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	i2c0: i2c at 20000000 {
 		compatible = "rockchip,rv1108-i2c";
 		reg = <0x20000000 0x1000>;
-- 
2.7.4
