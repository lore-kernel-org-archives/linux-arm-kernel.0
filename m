From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Fri, 17 May 2013 15:35:44 +0200
Subject: [PATCH 2/2] Add sunxi-sid to dts for sun4i and sun5i
In-Reply-To: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
Message-ID: <1368797744-13737-3-git-send-email-oliver+list@schinagl.nl>
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
index e7ef619..1043db2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -163,6 +163,11 @@
 		reg = <0x01c20000 0x300000>;
 		ranges;
 
+		sid: eeprom at 01c23800 {
+			compatible = "allwinner,sun4i-sid";
+			reg = <0x01c23800 0x10>;
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 8ba65c1..f715132 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -153,6 +153,11 @@
 		reg = <0x01c20000 0x300000>;
 		ranges;
 
+		sid: eeprom at 01c23800 {
+			compatible = "allwinner,sun4i-sid";
+			reg = <0x01c23800 0x10>;
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.8.1.5
