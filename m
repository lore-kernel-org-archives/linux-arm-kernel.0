From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:29 +0100
Subject: [PATCH 7/9] ARM: vexpress: Convert V2P-CA15 Device Tree to 64 bit
 addresses
In-Reply-To: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1342013791-19516-8-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... to enable use of LPAE, which extends physical address space
to 40 bits.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |   36 +++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 7e1091d..d12b34c 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -14,8 +14,8 @@
 	arm,hbi = <0x237>;
 	compatible = "arm,vexpress,v2p-ca15,tc1", "arm,vexpress,v2p-ca15", "arm,vexpress";
 	interrupt-parent = <&gic>;
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	chosen { };
 
@@ -47,23 +47,23 @@
 
 	memory at 80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x40000000>;
+		reg = <0 0x80000000 0 0x40000000>;
 	};
 
 	hdlcd at 2b000000 {
 		compatible = "arm,hdlcd";
-		reg = <0x2b000000 0x1000>;
+		reg = <0 0x2b000000 0 0x1000>;
 		interrupts = <0 85 4>;
 	};
 
 	memory-controller at 2b0a0000 {
 		compatible = "arm,pl341", "arm,primecell";
-		reg = <0x2b0a0000 0x1000>;
+		reg = <0 0x2b0a0000 0 0x1000>;
 	};
 
 	wdt at 2b060000 {
 		compatible = "arm,sp805", "arm,primecell";
-		reg = <0x2b060000 0x1000>;
+		reg = <0 0x2b060000 0 0x1000>;
 		interrupts = <98>;
 	};
 
@@ -72,23 +72,23 @@
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-		reg = <0x2c001000 0x1000>,
-		      <0x2c002000 0x1000>,
-		      <0x2c004000 0x2000>,
-		      <0x2c006000 0x2000>;
+		reg = <0 0x2c001000 0 0x1000>,
+		      <0 0x2c002000 0 0x1000>,
+		      <0 0x2c004000 0 0x2000>,
+		      <0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
 	};
 
 	memory-controller at 7ffd0000 {
 		compatible = "arm,pl354", "arm,primecell";
-		reg = <0x7ffd0000 0x1000>;
+		reg = <0 0x7ffd0000 0 0x1000>;
 		interrupts = <0 86 4>,
 			     <0 87 4>;
 	};
 
 	dma at 7ffb0000 {
 		compatible = "arm,pl330", "arm,primecell";
-		reg = <0x7ffb0000 0x1000>;
+		reg = <0 0x7ffb0000 0 0x1000>;
 		interrupts = <0 92 4>,
 			     <0 88 4>,
 			     <0 89 4>,
@@ -111,12 +111,12 @@
 	};
 
 	motherboard {
-		ranges = <0 0 0x08000000 0x04000000>,
-			 <1 0 0x14000000 0x04000000>,
-			 <2 0 0x18000000 0x04000000>,
-			 <3 0 0x1c000000 0x04000000>,
-			 <4 0 0x0c000000 0x04000000>,
-			 <5 0 0x10000000 0x04000000>;
+		ranges = <0 0 0 0x08000000 0x04000000>,
+			 <1 0 0 0x14000000 0x04000000>,
+			 <2 0 0 0x18000000 0x04000000>,
+			 <3 0 0 0x1c000000 0x04000000>,
+			 <4 0 0 0x0c000000 0x04000000>,
+			 <5 0 0 0x10000000 0x04000000>;
 
 		interrupt-map-mask = <0 0 63>;
 		interrupt-map = <0 0  0 &gic 0  0 4>,
-- 
1.7.9.5
