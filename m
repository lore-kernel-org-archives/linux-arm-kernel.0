From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 18 Jan 2018 10:34:18 -0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
Message-ID: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the kernel hangs when USB Host1 is enabled due to the lack of
support for controlling the USB hub clock and GPIO reset line.

Peter Chen has made several attempts to fix this problem, but his series
has not been applied yet, so better disable USB host1 for now to avoid
the kernel hang.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 4161b7d..1f0b9f6 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -274,7 +274,8 @@
 	pinctrl-0 = <&pinctrl_usbh>;
 	vbus-supply = <&reg_usb_h1_vbus>;
 	clocks = <&clks IMX6QDL_CLK_CKO>;
-	status = "okay";
+	/* currently USB support causes a kernel hang. Disable it for now */
+	status = "disabled";
 };
 
 &usdhc3 {
-- 
2.7.4
