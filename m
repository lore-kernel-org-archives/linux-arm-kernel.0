From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 23 Feb 2015 14:02:03 +0100
Subject: [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network
 v2
Message-ID: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
wired to the I2C fan controller but to a separe GPIO. This GPIO can be
controlled by using the gpio-fan driver.

This patch adds the gpio-fan alarm description in the net2big_v2 DTS.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
index 53dc37a3b687..e4f7e497379f 100644
--- a/arch/arm/boot/dts/kirkwood-net2big.dts
+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
@@ -27,6 +27,11 @@
 		device_type = "memory";
 		reg = <0x00000000 0x10000000>;
 	};
+
+	gpio_fan {
+		compatible = "gpio-fan";
+		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &regulators {
-- 
2.1.1
