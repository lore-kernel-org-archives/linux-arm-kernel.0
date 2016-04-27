From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:48 -0500
Subject: [PATCH 5/5] ARM: dts: k2g-evm: Add pinmuxing for UART0
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <1461766308-27669-6-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Avoid depending on the bootloader or the ROM for configuring the pinmux by
explicitly setting the pinmux here.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 5bfd9e7..692fcbb 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -27,6 +27,17 @@
 
 };
 
+&k2g_pinctrl {
+	uart0_pins: pinmux_uart0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x11cc) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+		>;
+	};
+};
+
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
-- 
2.7.0
