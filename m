From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Sun,  2 Jun 2013 16:58:50 +0200
Subject: [PATCH 2/2] Add sunxi-sid to dts for sun4i and sun5i
In-Reply-To: <1370185130-15332-1-git-send-email-oliver+list@schinagl.nl>
References: <1370185130-15332-1-git-send-email-oliver+list@schinagl.nl>
Message-ID: <1370185130-15332-3-git-send-email-oliver+list@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver@schinagl.nl>

This should add support for the sunxi-sid driver to the device table for sun4i and sun5i

Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
 arch/arm/boot/dts/sun5i-a13.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e7ef619..bc71d64 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -213,6 +213,11 @@
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
index 8ba65c1..c80c81b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -196,6 +196,11 @@
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
-- 
1.8.1.5
