From: b32955@freescale.com (Huang Shijie)
Date: Wed, 3 Jul 2013 17:42:36 +0800
Subject: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
In-Reply-To: <1372844557-3078-1-git-send-email-b32955@freescale.com>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
Message-ID: <1372844557-3078-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In imx6q-arm2 board, the UART2 works in the dte mode.
So add a pinctrl for it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 9a69891..8a518c6 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -266,6 +266,15 @@
 							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
 						>;
 					};
+
+					pinctrl_uart2_dte: uart2grp-2 {
+						fsl,pins = <
+							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
+							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
+							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
+							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
-- 
1.7.1
