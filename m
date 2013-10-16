From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Wed, 16 Oct 2013 10:55:05 +0200
Subject: [PATCH] at91: serial: add usart3 in separat dtsi
Message-ID: <1381913705-16098-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usart3 for AT91SAM9G25 and X25.
Based on sugescion of Nicolas Ferre it's in separated dtsi file included in both
g25 and x25 files.

Signed-off-by:  <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9g25.dtsi       |    1 +
 arch/arm/boot/dts/at91sam9x25.dtsi       |    1 +
 arch/arm/boot/dts/at91sam9x5-usart3.dtsi |   27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9x5-usart3.dtsi

diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index b4ec6fe..980e9a7 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5-usart3.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G25 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 49e94ab..3ac17ee 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "at91sam9x5.dtsi"
+#include "at91sam9x5-usart3.dtsi"
 
 / {
 	model = "Atmel AT91SAM9X25 SoC";
diff --git a/arch/arm/boot/dts/at91sam9x5-usart3.dtsi b/arch/arm/boot/dts/at91sam9x5-usart3.dtsi
new file mode 100644
index 0000000..f5b6979
--- /dev/null
+++ b/arch/arm/boot/dts/at91sam9x5-usart3.dtsi
@@ -0,0 +1,27 @@
+/*
+ * at91sam9x5-usert3.dtsi - Device Tree Include file for AT91SAM9G25 or 
+ * AT91SAM9X25 SoC
+ *
+ * Copyright (C) 2013 Jiri Prchal <jiri.prchal@aksignal.cz>
+ *
+ * Licensed under GPLv2.
+ */
+
+/ {
+	aliases {
+		serial4 = &usart3;
+	};
+
+	ahb {
+		apb {
+			usart3: serial at f8028000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8028000 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usart3>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.7.9.5
