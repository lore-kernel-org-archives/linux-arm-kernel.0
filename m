From: alexanders83@web.de (Alexander Stein)
Date: Fri, 19 Dec 2014 09:51:39 +0100
Subject: [PATCH 2/3] ARM: at91/dt: add SMC0/1  nodes in at91sam9263 dtsi
In-Reply-To: <1418979100-13243-1-git-send-email-alexanders83@web.de>
References: <1418979100-13243-1-git-send-email-alexanders83@web.de>
Message-ID: <1418979100-13243-3-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SMC0/1 (Static Memory Controller) nodes in at91sam9263sama5d3 dtsi.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 8cc5337..914990b 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -351,11 +351,21 @@
 				reg = <0xffffe200 0x200>;
 			};
 
+			smc0: smc0 at ffffe400 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffe400 0x200>;
+			};
+
 			ramc1: ramc at ffffe800 {
 				compatible = "atmel,at91sam9260-sdramc";
 				reg = <0xffffe800 0x200>;
 			};
 
+			smc1: smc1 at ffffea00 {
+				compatible = "atmel,at91sam9260-smc", "syscon";
+				reg = <0xffffea00 0x200>;
+			};
+
 			matrix: matrix at ffffec00 {
 				compatible = "atmel,at91sam9263-matrix", "syscon";
 				reg = <0xffffec00 0x200>;
-- 
2.2.1
