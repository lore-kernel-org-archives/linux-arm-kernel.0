From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue,  5 Aug 2014 13:34:01 -0400
Subject: [PATCH 2/2] ARM: dts: vf610-twr: Add ttyLP2 device.
In-Reply-To: <1407260041-19234-1-git-send-email-bpringlemeir@nbsps.com>
References: <1407260041-19234-1-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <1407260041-19234-3-git-send-email-bpringlemeir@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ttyLP1 is already the default console/serial port.  The
tower board will route ttyLP2 to the same connectors depending
on the JP23/24 settings.

See:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276457.html
 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275576.html

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b8a5e8c..58e988e 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -221,8 +221,6 @@
 				VF610_PAD_PTB1__FTM0_CH1		0x1582
 				VF610_PAD_PTB2__FTM0_CH2		0x1582
 				VF610_PAD_PTB3__FTM0_CH3		0x1582
-				VF610_PAD_PTB6__FTM0_CH6		0x1582
-				VF610_PAD_PTB7__FTM0_CH7		0x1582
 			>;
 		};
 
@@ -244,6 +242,13 @@
 				VF610_PAD_PTB5__UART1_RX		0x21a1
 			>;
 		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				VF610_PAD_PTB6__UART2_TX		0x21a2
+				VF610_PAD_PTB7__UART2_RX		0x21a1
+			>;
+		};
 	};
 };
 
@@ -265,3 +270,9 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
-- 
1.8.0.2
