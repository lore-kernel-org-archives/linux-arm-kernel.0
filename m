From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Sep 2015 12:29:48 +0200
Subject: [PATCH v2 resend 1/4] ARM: dts: sun5i: Add PWM controller node for
 A13/A10s
In-Reply-To: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
References: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1443522591-6590-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun5i die has a PWM controller that is compatible to the one on the A20.
Add a device node for it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 78b993a..5e036a4 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -543,6 +543,14 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		pwm: pwm at 01c20e00 {
+			compatible = "allwinner,sun7i-a20-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.5.0
