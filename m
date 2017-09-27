From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:16:52 +0200
Subject: [PATCH 1/4] ARM: dts: add the PCI clock to the device tree
In-Reply-To: <20170927211655.3687-1-linus.walleij@linaro.org>
References: <20170927211655.3687-1-linus.walleij@linaro.org>
Message-ID: <20170927211655.3687-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIv3 driver needs to fetch this clock, so add it to the
device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index e8b249f92fb3..152d59821db0 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -160,6 +160,7 @@
 		reg = <0x62000000 0x10000>;
 		interrupt-parent = <&pic>;
 		interrupts = <17>; /* Bus error IRQ */
+		clocks = <&pciclk>;
 		ranges = <0x00000000 0 0x61000000 /* config space */
 			0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
 			0x01000000 0 0x0 /* I/O space */
-- 
2.13.5
