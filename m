From: mporter@konsulko.com (Matt Porter)
Date: Fri, 27 Feb 2015 09:06:00 -0500
Subject: [PATCH] ARM: dts: imx: Add dr_mode host setting to all host-only usb
 instances
Message-ID: <1425045960-14191-1-git-send-email-mporter@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chipidea driver adds an extra line of spam to the log when a
host-only chipidea instance is left set to the default of a dual role
controller.

[    2.010873] ci_hdrc ci_hdrc.1: doesn't support gadget

Set the dr_mode property to host on all the host-only nodes
to avoid this warning.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm/boot/dts/imx27.dtsi   | 2 ++
 arch/arm/boot/dts/imx28.dtsi   | 1 +
 arch/arm/boot/dts/imx35.dtsi   | 1 +
 arch/arm/boot/dts/imx50.dtsi   | 3 +++
 arch/arm/boot/dts/imx51.dtsi   | 3 +++
 arch/arm/boot/dts/imx53.dtsi   | 3 +++
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 9 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 4b063b6..6951b66 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -488,6 +488,7 @@
 				interrupts = <54>;
 				clocks = <&clks IMX27_CLK_USB_IPG_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -497,6 +498,7 @@
 				interrupts = <55>;
 				clocks = <&clks IMX27_CLK_USB_IPG_GATE>;
 				fsl,usbmisc = <&usbmisc 2>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47f68ac..02330f4 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1197,6 +1197,7 @@
 			interrupts = <92>;
 			clocks = <&clks 61>;
 			fsl,usbphy = <&usbphy1>;
+			dr_mode = "host";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 6932928..b6478e9 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -318,6 +318,7 @@
 				clocks = <&clks 73>;
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 620b0f0..e245713 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -197,6 +197,7 @@
 				reg = <0x53f80200 0x0200>;
 				interrupts = <14>;
 				clocks = <&clks IMX5_CLK_USB_PHY2_GATE>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -205,6 +206,7 @@
 				reg = <0x53f80400 0x0200>;
 				interrupts = <16>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -213,6 +215,7 @@
 				reg = <0x53f80600 0x0200>;
 				interrupts = <17>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index c0116cf..f46fe9b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -265,6 +265,7 @@
 				interrupts = <14>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -274,6 +275,7 @@
 				interrupts = <16>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 2>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -283,6 +285,7 @@
 				interrupts = <17>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 3>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index ff4fa7e..c3e3ca9 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -309,6 +309,7 @@
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -318,6 +319,7 @@
 				interrupts = <16>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 2>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -327,6 +329,7 @@
 				interrupts = <17>;
 				clocks = <&clks IMX5_CLK_USBOH3_GATE>;
 				fsl,usbmisc = <&usbmisc 3>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d6c69ec..9347c93 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -845,6 +845,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -854,6 +855,7 @@
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
@@ -863,6 +865,7 @@
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 3>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 36ab8e0..9bf1db3 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -699,6 +699,7 @@
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7a24fee..fdadd060 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -763,6 +763,7 @@
 				fsl,usbmisc = <&usbmisc 2>;
 				phy_type = "hsic";
 				fsl,anatop = <&anatop>;
+				dr_mode = "host";
 				status = "disabled";
 			};
 
-- 
1.8.4
