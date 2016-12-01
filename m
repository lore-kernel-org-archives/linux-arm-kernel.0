From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 1 Dec 2016 11:49:49 +0100
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2 Xplained: use DMA for UART3
In-Reply-To: <20161201104949.23985-1-nicolas.ferre@atmel.com>
References: <20161201104949.23985-1-nicolas.ferre@atmel.com>
Message-ID: <20161201104949.23985-3-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DMA for UART3 as we have enough channels and to show how to
specify DMA use with serial nodes.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d5fdac..e2d5cb3fecb1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -256,6 +256,8 @@
 			};
 
 			uart3: serial at fc008000 {
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart3_default>;
 				status = "okay";
-- 
2.9.0
