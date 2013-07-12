From: b32955@freescale.com (Huang Shijie)
Date: Fri, 12 Jul 2013 16:51:19 +0800
Subject: [PATCH fix] ARM: dts: imx6qdl-sabreauto: add a DT node for uart3
In-Reply-To: <20130712084025.GH25501@S2101-09.ap.freescale.net>
References: <20130712084025.GH25501@S2101-09.ap.freescale.net>
Message-ID: <1373619079-14049-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT node for uart3, in the imx6q{dl}-sabreauto boards,
the uart3 is used by Bluetooth.

Since the uart3 has pin conflict with gpmi and weim nor, we keep it
disabled by default.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 1cbbc51..4f99ddd 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -67,6 +67,13 @@
 	};
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1>;
+	fsl,uart-has-rtscts;
+	status = "disabled"; /* used by the BT, pin conflict with gpmi and weim NOR */
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4_1>;
-- 
1.7.1
