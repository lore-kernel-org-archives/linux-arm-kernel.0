From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 19 Jan 2017 23:05:39 +0100
Subject: [PATCH] ARM: dts: at91: Enable DMA on sama5d2_xplained console
Message-ID: <20170119220539.19011-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA on uart1 to get a more reliable console.

Cc: stable <stable@vger.kernel.org> #v4.3+
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d5fdac..30fac04289a5 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -148,6 +148,8 @@
 			uart1: serial at f8020000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1_default>;
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
 				status = "okay";
 			};
 
-- 
2.11.0
