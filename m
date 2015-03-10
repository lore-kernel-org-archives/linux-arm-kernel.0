From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Mar 2015 19:59:16 +0800
Subject: [PATCH v5 05/12] ARM: dts: sun6i: hummingbird: Add AXP221 PMIC device
 node
In-Reply-To: <1425988764-23618-1-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
Message-ID: <1425988764-23618-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has an AXP221 PMIC hooked up to the
P2WI controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 533bedc5dd95..486ffc69ac96 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -142,6 +142,15 @@
 
 &p2wi {
 	status = "okay";
+
+	axp221: pmic at 68 {
+		compatible = "x-powers,axp221";
+		reg = <0x68>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
 };
 
 &reg_usb1_vbus {
-- 
2.1.4
