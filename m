From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 5 May 2014 14:58:29 -0500
Subject: [PATCH 2/2] ARM: dts: am335x-evmsk: Add vtt_fixed regulator
In-Reply-To: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
References: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1399319909-53795-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VTT regulator for DDR3 termination on the am335x-evmsk is
controlled by a gpio. It is configured by the bootloader so here we
define an always-on, fixed voltage regulator to hold the gpio.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index ab23885..d6b8acb 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -57,6 +57,17 @@
 		enable-active-high;
 	};
 
+	vtt_fixed: fixedregulator at 3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+	};
+
 	leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds_s0>;
-- 
1.9.0
