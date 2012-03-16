From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:24 +0000
Subject: [PATCH 4/9] ARM: kirkwood: fdt: use mrvl ticker symbol
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <12bc9d34d737beecb2c7a0703bd779b025e94721.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, use inclusive register size for uart0.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |    4 ++--
 arch/arm/boot/dts/kirkwood.dtsi          |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 8a5dff8..333f11b 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -4,7 +4,7 @@
 
 / {
 	model = "Globalscale Technologies Dreamplug";
-	compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+	compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
 
 	memory {
 		device_type = "memory";
@@ -17,7 +17,7 @@
 
 	serial at f1012000 {
 		compatible = "ns16550a";
-		reg = <0xf1012000 0xff>;
+		reg = <0xf1012000 0x100>;
 		reg-shift = <2>;
 		interrupts = <33>;
 		clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 771c6bb..702b955 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,6 +1,6 @@
 /include/ "skeleton.dtsi"
 
 / {
-	compatible = "marvell,kirkwood";
+	compatible = "mrvl,kirkwood";
 };
 
-- 
1.7.3.4
