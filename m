From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 12:45:08 +0400
Subject: [PATCH 5/5] ARM: dts: i.MX51: Switch to use standard IRQ flags
 definitions
In-Reply-To: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
Message-ID: <1383813908-26571-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 +-
 arch/arm/boot/dts/imx51.dtsi        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 8245b1f..5a77d33 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -148,7 +148,7 @@
 		spi-cs-high;
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <8 0x4>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 
 		regulators {
 			sw1_reg: sw1 {
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index e0d7f5b..0ffddb5 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -13,6 +13,7 @@
 #include "skeleton.dtsi"
 #include "imx51-pinfunc.h"
 #include "imx51-pingrp.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	aliases {
-- 
1.8.1.5
