From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Aug 2015 12:47:13 +0800
Subject: [PATCH v2 05/10] ARM: imx6: set ahb-burst-config as 0 for USB
In-Reply-To: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438577238-10153-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After setting ahb burst configuration as 0, we can increase tx/rx
burst size, it will improve the USB performance

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6d1359..42d62b0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -853,6 +853,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -864,6 +865,7 @@
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -874,6 +876,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -884,6 +887,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 3>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a78e715..066fac9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -688,6 +688,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -698,6 +699,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -708,6 +710,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..3656a1d 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -746,6 +746,7 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -756,6 +757,7 @@
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -768,6 +770,7 @@
 				phy_type = "hsic";
 				fsl,anatop = <&anatop>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
-- 
1.9.1
