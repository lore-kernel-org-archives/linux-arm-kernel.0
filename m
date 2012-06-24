From: stigge@antcom.de (Roland Stigge)
Date: Sun, 24 Jun 2012 15:47:14 +0200
Subject: [PATCH 4/7] ARM: LPC32xx: Update DTS file for EA3250 board
In-Reply-To: <1340545637-5449-1-git-send-email-stigge@antcom.de>
References: <1340545637-5449-1-git-send-email-stigge@antcom.de>
Message-ID: <1340545637-5449-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DTS file update adds:
* 3-channel ADC (for AD-IN on AD2, or 3-axis-accelerometer)
* Interrupt key

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/boot/dts/ea3250.dts |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- linux-2.6.orig/arch/arm/boot/dts/ea3250.dts
+++ linux-2.6/arch/arm/boot/dts/ea3250.dts
@@ -152,6 +152,23 @@
 			uart1: serial at 40014000 {
 				status = "okay";
 			};
+
+			/* 3-axis accelerometer X,Y,Z (or AD-IN instead of Z) */
+			adc at 40048000 {
+				status = "okay";
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		button at 21 {
+			label = "GPIO Key UP";
+			linux,code = <103>;
+			gpios = <&gpio 4 1 0>; /* GPI_P3 1 */
 		};
 	};
 };
