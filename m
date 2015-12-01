From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:06 +0200
Subject: [PATCH V3 04/19] ARM: dts: am57xx: cl-som-am57x: add EEPROM support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-5-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board EEPROM chip is used for storing a board production
info.

Add module EEPROM support (over I2C4 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

  v3: 
 
   * No fuctional changes 
   * Reformat subject 

  v2:

   * Fix EEPROM chip model

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 2074fd4..1badfa9 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -261,6 +261,12 @@
 		compatible = "emmicro,em3027";
 		reg = <0x56>;
 	};
+
+	eeprom_module: atmel at 50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 &cpu0 {
-- 
1.9.1
