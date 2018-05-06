From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:47 +0200
Subject: [PATCH 2/7] ARM: dtd: Set DNS-313 LEDs to use better triggers
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We just used one LED for "disk activity" but using the green
LED for disk read and the red LED for disk write gives a way
better user experience.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 55b294f1675c..2d9aa5ba8320 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -59,14 +59,13 @@
 			label = "dns313:green:disk";
 			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
-			linux,default-trigger = "ide-disk";
-			/* Ideally should activate while reading */
+			linux,default-trigger = "disk-read";
 		};
 		led-disk-red {
 			label = "dns313:red:disk";
 			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
-			/* Ideally should activate while writing */
+			linux,default-trigger = "disk-write";
 		};
 	};
 
-- 
2.17.0
