From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Tue, 17 Sep 2013 11:57:37 +0200
Subject: [PATCH] at91: mmc: fix missing pinctrl in dt
In-Reply-To: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <1379411857-18516-2-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl to soc dtsi file.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cf78ac0..c5d26b0 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -556,6 +556,8 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
1.7.9.5
