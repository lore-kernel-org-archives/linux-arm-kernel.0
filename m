From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:18 +0800
Subject: [PATCH 07/12] ARM: imx6: set ahb-burst-config as 0 for USB
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-8-git-send-email-peter.chen@freescale.com>
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
index d6c69ec..2430cc9 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -835,6 +835,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -845,6 +846,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -854,6 +856,7 @@
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -863,6 +866,7 @@
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 3>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 36ab8e0..9f283cc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -680,6 +680,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -690,6 +691,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -699,6 +701,7 @@
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7a24fee..0cdfa01 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -742,6 +742,7 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -752,6 +753,7 @@
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -763,6 +765,7 @@
 				fsl,usbmisc = <&usbmisc 2>;
 				phy_type = "hsic";
 				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
-- 
1.9.1
