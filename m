From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:15 +0200
Subject: [PATCH 2/7] ARM: dts: at91: vinco: fix regulator name
In-Reply-To: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468574720-24296-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vcc_3v3_reg is a fixed regulator and doesn't need a reg property. Remove
its unit-address.

Solves:
Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-vinco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index 6a366ee952a8..e0c0b2897a49 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -245,7 +245,7 @@
 
 	};
 
-	vcc_3v3_reg: fixedregulator at 0 {
+	vcc_3v3_reg: fixedregulator_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC 3V3";
 		regulator-min-microvolt = <3300000>;
-- 
2.8.1
