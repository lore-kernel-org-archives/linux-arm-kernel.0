From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jul 2013 09:49:33 -0300
Subject: [PATCH v3 4/4] ARM: dts: imx6dl-wandboard: Add support for UART3
In-Reply-To: <1373633373-3352-1-git-send-email-festevam@gmail.com>
References: <1373633373-3352-1-git-send-email-festevam@gmail.com>
Message-ID: <1373633373-3352-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Wandboard has a bluetooth device connected to UART3, so add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Rebased against imx-dt tree.
- Separate board changes from SoC changes
Changes since v1:
- Also add the usdhc pinmux groups to mx6q

 arch/arm/boot/dts/imx6dl-wandboard.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index fe9a01d..15014bb 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -108,6 +108,13 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &usbh1 {
 	status = "okay";
 };
-- 
1.8.1.2
