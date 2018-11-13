From: vigneshr@ti.com (Vignesh R)
Date: Tue, 13 Nov 2018 11:31:10 +0530
Subject: [PATCH v2 3/4] arm64: dts: ti: am654-base-board: Add pinmux for main
 uart0
In-Reply-To: <20181113060111.16374-1-vigneshr@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
Message-ID: <20181113060111.16374-4-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux for main uart0 that is serves as console on AM654 EVM

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index e146ac2ad781..cbf9d3dfeaa3 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -35,7 +35,23 @@
 	};
 };
 
+&main_pmx0 {
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01e4, PIN_INPUT, 0)	/* (AF11) UART0_RXD */
+			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)	/* (AE11) UART0_TXD */
+			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
+			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "disabled";
 };
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
-- 
2.19.1
