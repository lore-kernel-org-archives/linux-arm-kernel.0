From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 28 Aug 2013 14:38:55 +0200
Subject: [PATCH 9/9] ARM: at91/dt: add new at91rm9200ek_dataflash board
In-Reply-To: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1377693535-11171-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new at91rm9200ek_dataflash board (based on at91rm9200ek board) which
enables dataflash connected to cs3 of spi0.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200ek_dataflash.dts |   33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91rm9200ek_dataflash.dts

diff --git a/arch/arm/boot/dts/at91rm9200ek_dataflash.dts b/arch/arm/boot/dts/at91rm9200ek_dataflash.dts
new file mode 100644
index 0000000..a43412e
--- /dev/null
+++ b/arch/arm/boot/dts/at91rm9200ek_dataflash.dts
@@ -0,0 +1,33 @@
+/*
+ * at91rm9200ek.dts - Device Tree file for Atmel AT91RM9200 evaluation kit with
+ *                    2 SPI dataflash
+ *
+ *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
+ *
+ * Licensed under GPLv2 only
+ */
+/dts-v1/;
+#include "at91rm9200ek.dts"
+
+/ {
+	model = "Atmel AT91RM9200 evaluation kit with 2 SPI dataflash";
+	compatible = "atmel,at91rm9200ek-dataflash", "atmel,at91rm9200ek", "atmel,at91rm9200";
+
+	ahb {
+		apb {
+			spi0: spi at fffe0000 {
+				pinctrl-0 = <&pinctrl_spi0 &pinctrl_spi0_cs0
+					     &pinctrl_spi0_cs3
+					     &pinctrl_spi0_cs3_switch>;
+				cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>, <0>,
+					   <0>, <&pioA 6 GPIO_ACTIVE_HIGH>;
+
+				mtd_dataflash at 3 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <15000000>;
+					reg = <3>;
+				};
+			};
+		};
+	};
+};
-- 
1.7.9.5
