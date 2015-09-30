From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 10:17:16 +0800
Subject: [RESEND PATCH v2 1/2] ARM: imx6: set ahb-burst-config as 0 for USB
Message-ID: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After setting ahb burst configuration as 0, we can increase tx/rx
burst size, it will improve the USB performance

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---

Changes for v2:
- Applies changes for imx6ul

 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e716e6f..3d04a17 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -906,6 +906,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -917,6 +918,7 @@
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -927,6 +929,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -937,6 +940,7 @@
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 3>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 320a27f..057b1d4 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -689,6 +689,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -699,6 +700,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -709,6 +711,7 @@
 				clocks = <&clks IMX6SL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index c94f2ea..70a7c4f 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -783,6 +783,7 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -793,6 +794,7 @@
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -805,6 +807,7 @@
 				phy_type = "hsic";
 				fsl,anatop = <&anatop>;
 				dr_mode = "host";
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 09edbed..654009f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -535,6 +535,7 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
@@ -545,6 +546,7 @@
 				clocks = <&clks IMX6UL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
 				status = "disabled";
 			};
 
-- 
1.9.1
