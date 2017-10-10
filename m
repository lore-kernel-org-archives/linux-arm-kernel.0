From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:49 +0300
Subject: [PATCH v2 14/14] ARM: dts: at91: at91sam9x5ek: use DMA for USART0
In-Reply-To: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507630189-15504-15-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Use DMA for USART0 (which is used as ttyS1) as we have enough channels and to
show how to specify DMA use with serial nodes.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 9d2bbc41a7b0..a85eb51e6aa8 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -50,6 +50,8 @@
 			};
 
 			usart0: serial at f801c000 {
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
 				status = "okay";
 			};
 
-- 
2.7.4
