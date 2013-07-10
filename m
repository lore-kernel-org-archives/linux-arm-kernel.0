From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Jul 2013 17:40:27 +0800
Subject: [PATCH 2/2] ARM: dts: imx6q{dl}-sabreauto: add a DT node for uart3
In-Reply-To: <1373449227-11740-1-git-send-email-b32955@freescale.com>
References: <1373449227-11740-1-git-send-email-b32955@freescale.com>
Message-ID: <1373449227-11740-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dt node for uart3, in the imx6q{dl}-sabreauto boards,
the uart3 is used by Bluetooth.

Since the uart3 has pin conflict with gpmi and weim nor, we keep it
disabled by default.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index e994011..765c9d5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -45,6 +45,15 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1>;
+	fsl,uart-has-rtscts;
+	dma-names = "rx", "tx";
+	dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
+	status = "disabled"; /* used by the BT, pin conflict with gpmi and weim NOR */
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.1
