From: joelf@ti.com (Joel Fernandes)
Date: Sat, 5 Oct 2013 14:04:37 -0500
Subject: [PATCH v3 3/3] ARM: dts: AM33XX: Fix AES interrupt number
In-Reply-To: <1380999877-20884-1-git-send-email-joelf@ti.com>
References: <1380999877-20884-1-git-send-email-joelf@ti.com>
Message-ID: <1380999877-20884-4-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AES interrupts were previously not used, but after recent changes to omap-aes
driver, its being used. We correct the interrupt number to have working PIO
mode.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 2664da9..5c2d6c1 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -724,7 +724,7 @@
 			compatible = "ti,omap4-aes";
 			ti,hwmods = "aes";
 			reg = <0x53500000 0xa0>;
-			interrupts = <102>;
+			interrupts = <103>;
 			dmas = <&edma 6>,
 			       <&edma 5>;
 			dma-names = "tx", "rx";
-- 
1.8.1.2
