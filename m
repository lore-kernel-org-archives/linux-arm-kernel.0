From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 00:45:06 +0200
Subject: [PATCH 2/4] ARM: dts: at91: sama5d4_xplained: fix regulator names
In-Reply-To: <1468363508-23843-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468363508-23843-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468363508-23843-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vcc_3v3_reg and vcc_mmc1_reg are fixed regulators and don't need a reg
property. Remove their unit-address.

Solves:
Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /fixedregulator at 1 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index da84e65b56ef..ed7fce297738 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -252,7 +252,7 @@
 		};
 	};
 
-	vcc_3v3_reg: fixedregulator at 0 {
+	vcc_3v3_reg: fixedregulator_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC 3V3";
 		regulator-min-microvolt = <3300000>;
@@ -261,7 +261,7 @@
 		regulator-always-on;
 	};
 
-	vcc_mmc1_reg: fixedregulator at 1 {
+	vcc_mmc1_reg: fixedregulator_mmc1 {
 		compatible = "regulator-fixed";
 		gpio = <&pioE 4 GPIO_ACTIVE_LOW>;
 		regulator-name = "VDD MCI1";
-- 
2.8.1
