From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:10 +0200
Subject: [PATCH 13/16] arm: at91: dt: sam9g20ek: use rts/cts/dtr/dsr/dcd/ri
 pinctrl group for uart0
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-13-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..e33ab0a 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -35,6 +35,12 @@
 			};
 
 			usart0: serial at fffb0000 {
+				pinctrl-0 =
+					<&pinctrl_uart0
+					 &pinctrl_uart0_rts_cts
+					 &pinctrl_uart0_dtr_dsr
+					 &pinctrl_uart0_dcd
+					 &pinctrl_uart0_ri>;
 				status = "okay";
 			};
 
-- 
1.7.10.4
