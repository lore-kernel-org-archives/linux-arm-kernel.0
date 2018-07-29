From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 29 Jul 2018 22:00:38 +0200
Subject: [PATCH v3 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi
 S700
In-Reply-To: <20180729200038.11795-1-sravanhome@gmail.com>
References: <20180729182551.19383-1-sravanhome@gmail.com>
 <20180729200038.11795-1-sravanhome@gmail.com>
Message-ID: <20180729200038.11795-6-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..8fbd7b1570a7 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -165,5 +165,21 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl at e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 136>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.18.0
