From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:31 +0200
Subject: [PATCH v2 15/15] ARM: dts: rk3188-radxarock: add GPIO IR receiver node
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-16-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beniamino Galvani <b.galvani@gmail.com>

This adds a device tree node for the infrared receiver connected to a
GPIO pin on the Radxa Rock.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 7628b48..b7f3423 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -58,6 +58,13 @@
 		};
 	};
 
+	ir_recv: gpio-ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 10 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_recv_pin>;
+	};
+
 	vcc_sd0: sdmmc-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "sdmmc-supply";
@@ -191,6 +198,12 @@
 			rockchip,pins = <RK_GPIO3 27 RK_FUNC_GPIO &pcfg_output_low>;
 		};
 	};
+
+	ir-receiver {
+		ir_recv_pin: ir-recv-pin {
+			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.0.1
