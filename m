From: b32955@freescale.com (Huang Shijie)
Date: Fri, 5 Jul 2013 14:12:32 +0800
Subject: [PATCH v3 6/6] ARM: dts: enable the uart2 for imx6q-arm2
In-Reply-To: <1373004752-21302-1-git-send-email-b32955@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Message-ID: <1373004752-21302-7-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the uart2 for imx6q-arm2 board.
The uart2 works in the DTE mode, with the RTS/CTS and DMA enabled.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 4e54fde..e7e3b56 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -97,6 +97,16 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_2>;
+	fsl,dte-mode;
+	fsl,uart-has-rtscts;
+	dma-names = "rx", "tx";
+	dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.1
