From: oliver+list@schinagl.nl (oliver+list at schinagl.nl)
Date: Tue, 27 Aug 2013 16:13:05 +0200
Subject: [PATCH 2/2] Add sunxi-sid to dts for sun4i, sun5i and sun7i
In-Reply-To: <1377612785-7868-1-git-send-email-oliver+list@schinagl.nl>
References: <1377612785-7868-1-git-send-email-oliver+list@schinagl.nl>
Message-ID: <1377612785-7868-3-git-send-email-oliver+list@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver@schinagl.nl>

This patch shall add support for the sunxi-sid driver to the device
table for sun4i, sun5i and sun7i.

Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
 arch/arm/boot/dts/sun5i-a13.dtsi | 5 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index b2bd6e1..179e024 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -267,6 +267,11 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		sid: eeprom at 01c23800 {
+			compatible = "allwinner,sun4i-sid";
+			reg = <0x01c23800 0x10>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 7363211..999fdb3 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -223,6 +223,11 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		sid: eeprom at 01c23800 {
+			compatible = "allwinner,sun4i-sid";
+			reg = <0x01c23800 0x10>;
+		};
+
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index fb81e78..bcf32b4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -217,6 +217,12 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		sid: eeprom at 01c23800 {
+			compatible = "allwinner,sun7i-sid";
+			reg = <0x01c23800 0x200>;
+		};
+
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
1.8.1.5
