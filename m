From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:26 +0100
Subject: [PATCH v3 08/19] arm64: dts: allwinner: a64: Orange Pi Win: Add
 serdev BT node
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-9-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Win has the RTL8723BS WiFi/Bluetooth chip soldered on the
board, with the Bluetooth part connected to UART1.

At the moment there is no mainline driver for the BT part yet, although
there is one in development. However as this does not include a DT binding,
we just go with an empty stub for now to denote that the BT chip is on
that UART. This can later be filled with the right properties.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index e9a5640076ad..87c32635085b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -253,6 +253,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
+
+	rtl8723bs-bt {
+	};
 };
 
 /* On Pi-2 connector, RTS/CTS optional */
-- 
2.14.4
