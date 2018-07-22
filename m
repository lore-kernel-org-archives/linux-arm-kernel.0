From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 22 Jul 2018 18:36:01 +0200
Subject: [PATCH 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi
 S700
In-Reply-To: <20180722163601.28346-1-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
Message-ID: <20180722163601.28346-6-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..88edac21e03f 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -179,5 +179,11 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl at e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+		};
 	};
 };
-- 
2.18.0
