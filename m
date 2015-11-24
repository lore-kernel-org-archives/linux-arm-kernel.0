From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:12 +0200
Subject: [PATCH 11/14] ARM: am437x: cm-t43: dts: add support for baseboard
 eeprom
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-12-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SB-SOM baseboard comes with an on-board EEPROM. On SBC-T43 this EEPROM
resides on the i2c1 bus. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-sbc-t43.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index b2e3201..7394aa1 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -61,6 +61,12 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	eeprom_base: at24 at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 &i2c2 {
-- 
1.9.1
