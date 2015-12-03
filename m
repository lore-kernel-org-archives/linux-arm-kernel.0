From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Dec 2015 15:33:56 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: change IRQ number of UART3 of
 PH1-Pro4 SoC
In-Reply-To: <1449124437-18479-1-git-send-email-yamada.masahiro@socionext.com>
References: <1449124437-18479-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1449124437-18479-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART3 is assigned with IRQ 29 for old SoCs, IRQ 177 for new ones,
and PH1-Pro4 is on the boundary.

  PH1-sLD3: UART3 is unavailable
  PH1-LD4, PH1-sLD8: only IRQ 29 is supported
  PH1-Pro4: both IRQ 29 and 177 are supported
  PH1-Pro5, ProXstream2, PH1-LD6b: only IRQ 177 is supported

This SoC can choose either IRQ 29 or IRQ 177, but the former is shared
with another hardware (low speed serial0).  The latter is dedicated
for this hardware and more recommended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index 254642f..bbf3727 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -151,7 +151,7 @@
 			reg = <0x54006b00 0x40>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 29 4>;
+			interrupts = <0 177 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
 		};
-- 
1.9.1
