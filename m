From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:56 +0900
Subject: [PATCH 27/31] ARM: shmobile: kzm9g dts: Configure the HOME key as
 wake-up source
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <cab7562a92edb89668fe548f5d8c8300e7438c62.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Note that from now on any of the pfc8575 gpio keys will wake up the
system, as the pfc8575 cannot mask individual interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 022ba505f573..24b4cd24dceb 100644
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
2.1.4
