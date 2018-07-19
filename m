From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 19 Jul 2018 23:14:03 +0530
Subject: [PATCH v5 4/6] arm64: dts: actions: Enable I2C1 and I2C2 in
 Bubblegum-96 board
In-Reply-To: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
References: <20180719174405.7210-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180719174405.7210-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable I2C1 and I2C2 exposed on the low speed expansion connector in
Bubblegum-96 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index d0ba35df9015..57ae374cfb5a 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s900.dtsi"
+#include "s900-bubblegum-96-pins.dtsi"
 
 / {
 	compatible = "ucrobotics,bubblegum-96", "actions,s900";
@@ -35,6 +36,16 @@
 	clocks = <&cmu CLK_UART5>;
 };
 
+&i2c1 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C1>;
+};
+
+&i2c2 {
+	status = "okay";
+	clocks = <&cmu CLK_I2C2>;
+};
+
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
  *         NC = not connected (pin out but not routed from the chip to
-- 
2.17.1
