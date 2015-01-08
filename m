From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 18:38:11 +0100
Subject: [PATCH v4 09/12] ARM: mvebu: a38x: Add missing labels
In-Reply-To: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420738694-6163-10-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pintcrl label was missing. Adding it allowed referring it from the
root of the device tree. Also add the uart0 label used by the
bootloader.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 63fe15174fee..04fe80d101f8 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -173,7 +173,7 @@
 				status = "disabled";
 			};
 
-			serial at 12000 {
+			uart0: serial at 12000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12000 0x100>;
 				reg-shift = <2>;
@@ -193,7 +193,7 @@
 				status = "disabled";
 			};
 
-			pinctrl at 18000 {
+			pinctrl: pinctrl at 18000 {
 				reg = <0x18000 0x20>;
 
 				ge0_rgmii_pins: ge-rgmii-pins-0 {
-- 
1.9.1
