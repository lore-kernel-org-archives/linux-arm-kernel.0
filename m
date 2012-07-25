From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 25 Jul 2012 17:53:32 +0530
Subject: [PATCH v2 2/2] arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on
 AM335x-EVM
In-Reply-To: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
Message-ID: <1343219012-19472-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add D_CAN1 pinctrl node to am3358_pinmux master node to export
D_CAN functionality on AM335x EVM according to pinctrl-single
driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e4e1ccb..7f0fd6c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -46,3 +46,16 @@
 	regulator-boot-on;
 	regulator-always-on;
 };
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&d_can1_pins>;
+
+	d_can1_pins: pinmux_d_can_pins {
+		pinctrl-single,pins = <
+			0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
+			0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
+		>;
+	};
+};
-- 
1.7.9.5
