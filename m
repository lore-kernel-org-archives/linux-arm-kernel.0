From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:51 +0200
Subject: [PATCH 16/39] ARM: u300: augment device tree with DMA channels
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-17-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds DMA channel assignments to the MMC/SD-controller
and the two UARTs already in the U300 device tree, as we
have now defined a way to obtain DMA channels from the
device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index ae51dd1..6be932b 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -185,6 +185,8 @@
 			reg = <0xc0013000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <22>;
+			dmas = <&dmac 17 &dmac 18>;
+			dma-names = "tx", "rx";
 		};
 
 		uart1: serial at c0007000 {
@@ -192,6 +194,8 @@
 			reg = <0xc0007000 0x1000>;
 			interrupt-parent = <&vicb>;
 			interrupts = <20>;
+			dmas = <&dmac 38 &dmac 39>;
+			dma-names = "tx", "rx";
 		};
 
 		mmcsd: mmcsd at c0001000 {
@@ -206,6 +210,8 @@
 			cd-gpios = <&gpio 12 0x4>;
 			cd-inverted;
 			vmmc-supply = <&ab3100_ldo_g_reg>;
+			dmas = <&dmac 14>;
+			dma-names = "rx";
 		};
 	};
 };
-- 
1.7.11.3
