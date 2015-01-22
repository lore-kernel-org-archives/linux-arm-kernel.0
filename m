From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 22 Jan 2015 18:41:45 +0800
Subject: [PATCH v2] ARM: at91: sama5d4: dts: change the nand compatible string
In-Reply-To: <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
References: <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
Message-ID: <1421923305-10088-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we introduce a new "atmel,sama5d4-nand" compatible string for sama5d4,
so we need to apply it for sama5d4 chip.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

Changes in v2:
- still keep the old rm9200 nand compatible string for compatible old driver.

 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 1b0f30c..e40b1da 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -267,7 +267,7 @@
 		};
 
 		nand0: nand at 80000000 {
-			compatible = "atmel,at91rm9200-nand";
+			compatible = "atmel,sama5d4-nand", "atmel,at91rm9200-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
1.9.1
