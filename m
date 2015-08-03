From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Aug 2015 12:47:17 +0800
Subject: [PATCH v2 09/10] ARM: imx6: change default burst size for USB
In-Reply-To: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438577238-10153-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can improve the USB performance when choosing larger
burst size at some systems (bus size is larger), there is
no side effect if this burst size is larger than bus size.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 arch/arm/boot/dts/imx6sl.dtsi  | 6 ++++++
 arch/arm/boot/dts/imx6sx.dtsi  | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 42d62b0..b9f2e3a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -854,6 +854,8 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -866,6 +868,8 @@
 				fsl,usbmisc = <&usbmisc 1>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -877,6 +881,8 @@
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -888,6 +894,8 @@
 				fsl,usbmisc = <&usbmisc 3>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 066fac9..627549f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -689,6 +689,8 @@
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -700,6 +702,8 @@
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -711,6 +715,8 @@
 				fsl,usbmisc = <&usbmisc 2>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 3656a1d..6844e9e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -747,6 +747,8 @@
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -758,6 +760,8 @@
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
@@ -771,6 +775,8 @@
 				fsl,anatop = <&anatop>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
 				status = "disabled";
 			};
 
-- 
1.9.1
