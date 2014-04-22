From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 22 Apr 2014 13:52:19 -0500
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add vtt_fixed regulator
In-Reply-To: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1398192739-8901-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VTT regulator for DDR3 termination on the am437x-gp-evm is
controlled by a gpio. It is configured by the bootloader so here we
define an always-on, fixed voltage regulator to hold the gpio.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index a055f7f..e68d12c 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -27,6 +27,17 @@
 		enable-active-high;
 	};
 
+	vtt_fixed: fixedregulator-vtt {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
-- 
1.9.0
