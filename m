From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:48 +0200
Subject: [PATCH 3/7] ARM: dts: Set DNS-685 LEDs to use better triggers
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the blue LED for disk read and the orange LED for
disk write gives a better user experience.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 369c80076a61..8d3478cf840b 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -98,7 +98,7 @@
 		/*
 		 * These two LEDs are on the side of the device.
 		 * For electrical reasons, both LEDs cannot be active
-		 * at the same time so only blue or orange can on at
+		 * at the same time so only blue or orange can be on at
 		 * one time. Enabling both makes the LED go dark.
 		 * The LEDs both sit inside the unmount button and the
 		 * label on the case says "unmount".
@@ -108,12 +108,14 @@
 			/* Collides with LPC_SERIRQ, UART DTR, SSP FSC pins */
 			gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
+			linux,default-trigger = "disk-read";
 		};
 		led-orange-hd {
 			label = "dir685:orange:HD";
 			/* Collides with LPC_LAD[2], UART DSR, SSP ECLK pins */
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
+			linux,default-trigger = "disk-write";
 		};
 	};
 
-- 
2.17.0
