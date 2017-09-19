From: vigneshr@ti.com (Vignesh R)
Date: Tue, 19 Sep 2017 11:45:50 +0530
Subject: [RESEND PATCH 2/3] ARM: dts: keystone-k2g-evm: Enable PWM ECAP0
In-Reply-To: <20170919061551.11981-1-vigneshr@ti.com>
References: <20170919061551.11981-1-vigneshr@ti.com>
Message-ID: <20170919061551.11981-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PWM ECAP0 which will be used for display backlight.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index f462f1043531..808618e747eb 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -81,6 +81,12 @@
 			K2G_CORE_IOPAD(0x1110) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
 		>;
 	};
+
+	ecap0_pins: ecap0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1374) (BUFFER_CLASS_B | MUX_MODE4)	/* pr1_mdio_data.ecap0_in_apwm0_out */
+		>;
+	};
 };
 
 &uart0 {
@@ -112,3 +118,9 @@
 	memory-region = <&dsp_common_memory>;
 	status = "okay";
 };
+
+&ecap0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap0_pins>;
+};
-- 
2.14.1
