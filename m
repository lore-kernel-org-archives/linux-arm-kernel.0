From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:10:01 +0200
Subject: [PATCH v2 3/5] ARM: dts: meson8b: add the I2C_A, PWM_C and UART_B pins
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180922151003.4736-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are used for example on the Endless Mini (EC-100):
- I2C_A is connected to the Realtek RT5640 audio codec
- PWM_C (GPIODV_9) is connected to a PWM regulator which is used for
  VCCK (CPU voltage supply)
- UART_B is connected to the Bluetooth module (of the RTL8723BS SDIO
  wifi and Bluetooth combo chip)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index f77e419c1c65..4bbbbc6bea83 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -223,6 +223,13 @@
 			};
 		};
 
+		i2c_a_pins: i2c-a {
+			mux {
+				groups = "i2c_sda_a", "i2c_sck_a";
+				function = "i2c_a";
+			};
+		};
+
 		sd_b_pins: sd-b {
 			mux {
 				groups = "sd_d0_b", "sd_d1_b", "sd_d2_b",
@@ -230,6 +237,29 @@
 				function = "sd_b";
 			};
 		};
+
+		pwm_c1_pins: pwm-c1 {
+			mux {
+				groups = "pwm_c1";
+				function = "pwm_c";
+			};
+		};
+
+		uart_b0_pins: uart-b0 {
+			mux {
+				groups = "uart_tx_b0",
+				       "uart_rx_b0";
+				function = "uart_b";
+			};
+		};
+
+		uart_b0_cts_rts_pins: uart-b0-cts-rts {
+			mux {
+				groups = "uart_cts_b0",
+				       "uart_rts_b0";
+				function = "uart_b";
+			};
+		};
 	};
 };
 
-- 
2.19.0
