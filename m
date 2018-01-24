From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:34:12 +0100
Subject: [PATCH] ARM: dts: use a correct at24 fallback for
 at91-nattis-2-natte-2
Message-ID: <20180124213412.4612-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now require all at24 users to use the "atmel,<model>" fallback in
device tree for different manufacturers.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 3ea1d26e1c68..9ae2a9de6123 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -146,7 +146,7 @@
 	};
 
 	eeprom at 50 {
-		compatible = "nxp,24c02";
+		compatible = "nxp,24c02", "atmel,24c02";
 		reg = <0x50>;
 		pagesize = <16>;
 	};
-- 
2.16.1
