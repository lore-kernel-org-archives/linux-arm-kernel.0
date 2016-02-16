From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Feb 2016 11:15:07 +0900
Subject: [PATCH 5/9] ARM: dts: uniphier: add EEPROM node for ProXstream2
 Gentil board
In-Reply-To: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1455588911-9827-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an EEPROM (STMicroelectronics M24C64-WMN6TP) connected
to the I2C channel 0 of the SoC.  Its slave address is 0x54.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
index 9d7ec5c..0da3018 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
@@ -75,4 +75,9 @@
 
 &i2c0 {
 	status = "okay";
+
+	eeprom at 54 {
+		compatible = "st,24c64";
+		reg = <0x54>;
+	};
 };
-- 
1.9.1
