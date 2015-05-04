From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  4 May 2015 19:36:09 +0200
Subject: [PATCH] ARM: shmobile: kzm9g dts: Configure the HOME key as wake-up
 source
Message-ID: <1430760969-23368-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that from now on any of the pfc8575 gpio keys will wake up the
system, as the pfc8575 cannot mask individual interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 022ba505f57339a9..24b4cd24dceb2f9e 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -147,6 +147,7 @@
 			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			label = "SW1";
+			gpio-key,wakeup;
 		};
 	};
 
-- 
1.9.1
