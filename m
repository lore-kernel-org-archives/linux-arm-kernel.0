From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 26 Dec 2017 10:03:40 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add has-transaction-translator
 property to usb node for LD11
In-Reply-To: <1514250220-925-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1514250220-925-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1514250220-925-3-git-send-email-hayashi.kunihiko@socionext.com>
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
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 1c63d0a..f8d2635 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -347,6 +347,7 @@
 				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
+			has-transaction-translator;
 		};
 
 		usb1: usb at 5a810100 {
@@ -360,6 +361,7 @@
 				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
+			has-transaction-translator;
 		};
 
 		usb2: usb at 5a820100 {
@@ -373,6 +375,7 @@
 				 <&mio_clk 14>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 10>,
 				 <&mio_rst 14>;
+			has-transaction-translator;
 		};
 
 		mioctrl at 5b3e0000 {
-- 
2.7.4
