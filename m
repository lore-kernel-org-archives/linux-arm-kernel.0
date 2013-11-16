From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 16 Nov 2013 14:23:41 +0100
Subject: [PATCH 08/11] ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1384608224-9452-9-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

The IGEP AQUILA EXPANSION has a 32KBit EEPROM for user data storage.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-base0033.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 2878024..a76ea11 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -87,3 +87,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	eeprom: eeprom at 50 {
+		compatible = "at,24c256";
+		reg = <0x50>;
+	};
+};
+
-- 
1.8.4.2
