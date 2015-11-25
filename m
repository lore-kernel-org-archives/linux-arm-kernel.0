From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:36 +0200
Subject: [PATCH 04/18] ARM: am57xx: cl-som-am57x: dts: add EEPROM support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-5-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board EEPROM chip is used for storing a board production
info.

Add module EEPROM support (over I2C4 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index eb9b81b..b6919a7 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -289,6 +289,12 @@
 		compatible = "emmicro,em3027";
 		reg = <0x56>;
 	};
+
+	eeprom_module: atmel at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 
-- 
1.9.1
