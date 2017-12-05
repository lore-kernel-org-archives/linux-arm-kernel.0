From: vigneshr@ti.com (Vignesh R)
Date: Tue, 5 Dec 2017 12:18:12 +0530
Subject: [PATCH 2/2] ARM: dts: keystone-k2g-evm: Enable UART 2
In-Reply-To: <20171205064812.15758-1-vigneshr@ti.com>
References: <20171205064812.15758-1-vigneshr@ti.com>
Message-ID: <20171205064812.15758-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Franklin S Cooper Jr <fcooper@ti.com>

66AK2G GP EVM has a Baseboard Management Controller (BMC) on board.
This controller handles things like setting the SoCs boot mode along
with controlling the on board character LCD display module.

Enable UART2 which communicates with the BMC. This enables userspace
applications to display something on the onboard LCD controlled by the
BMC.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 8d100217e38f..9737730ddc21 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -115,6 +115,13 @@
 			K2G_CORE_IOPAD(0x121c) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* qspi_csn0.qspi_csn0 */
 		>;
 	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x11ec) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)      /* uart2_rxd.uart2_rxd */
+			K2G_CORE_IOPAD(0x11f0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)      /* uart2_txd.uart2_txd */
+		>;
+	};
 };
 
 &uart0 {
@@ -263,3 +270,9 @@
 		};
 	};
 };
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
-- 
2.15.0
