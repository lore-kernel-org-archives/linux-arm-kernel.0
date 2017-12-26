From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 26 Dec 2017 10:03:39 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add has-transaction-translator
 property to usb node for LD4, sLD8 and Pro4
In-Reply-To: <1514250220-925-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1514250220-925-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1514250220-925-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a full/low speed device is connected to USB 2.0 port on UniPhier SoC
that has ehci controller, the kernel shows the following messages.

| usb usb1-port1: Cannot enable. Maybe the USB cable is bad?
| usb usb1-port1: Cannot enable. Maybe the USB cable is bad?
| usb usb1-port1: Cannot enable. Maybe the USB cable is bad?
| usb usb1-port1: unable to enumerate USB device

To fix the issue, the driver needs to enable Transaction Translator on ehci
root hub. This adds 'has-transaction-translator' property to each node.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 3 +++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 2 ++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 01fc3e1..27f0781 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -235,6 +235,7 @@
 				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
+			has-transaction-translator;
 		};
 
 		usb1: usb at 5a810100 {
@@ -248,6 +249,7 @@
 				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
+			has-transaction-translator;
 		};
 
 		usb2: usb at 5a820100 {
@@ -261,6 +263,7 @@
 				 <&mio_clk 14>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 10>,
 				 <&mio_rst 14>;
+			has-transaction-translator;
 		};
 
 		soc-glue at 5f800000 {
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 7955c3a..c346147 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -269,6 +269,7 @@
 				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
+			has-transaction-translator;
 		};
 
 		usb3: usb at 5a810100 {
@@ -282,6 +283,7 @@
 				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
+			has-transaction-translator;
 		};
 
 		soc-glue at 5f800000 {
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 7188536..de28c52 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -239,6 +239,7 @@
 				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
+			has-transaction-translator;
 		};
 
 		usb1: usb at 5a810100 {
@@ -252,6 +253,7 @@
 				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
+			has-transaction-translator;
 		};
 
 		usb2: usb at 5a820100 {
@@ -265,6 +267,7 @@
 				 <&mio_clk 14>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 10>,
 				 <&mio_rst 14>;
+			has-transaction-translator;
 		};
 
 		soc-glue at 5f800000 {
-- 
2.7.4
