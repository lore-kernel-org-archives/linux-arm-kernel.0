From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 23 Mar 2016 23:24:21 +0100
Subject: [PATCH 4/4] arm64: dts: marvell: Rename armada-ap806 XOR nodes
In-Reply-To: <1458771861-12392-1-git-send-email-afaerber@suse.de>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
Message-ID: <1458771861-12392-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node names should not contain an instance number, the unit address
serves to distinguish nodes of the same name. So rename the XOR nodes
to just xor at address, using xorX as label instead.

Fixes: ec7e5a569bce ("arm64: dts: marvell: add Device Tree files for Armada 7K/8K")
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 "marvell,mv-xor-v2" is not yet referenced from any driver in next-20160323.
 
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 3ecf9b1798fa..dd6e48a952ac 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -135,7 +135,7 @@
 				marvell,spi-base = <128>, <136>, <144>, <152>;
 			};
 
-			xor0 at 400000 {
+			xor0: xor at 400000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x400000 0x1000>,
 				      <0x410000 0x1000>;
@@ -143,7 +143,7 @@
 				dma-coherent;
 			};
 
-			xor1 at 420000 {
+			xor1: xor at 420000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x420000 0x1000>,
 				      <0x430000 0x1000>;
@@ -151,7 +151,7 @@
 				dma-coherent;
 			};
 
-			xor2 at 440000 {
+			xor2: xor at 440000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x440000 0x1000>,
 				      <0x450000 0x1000>;
@@ -159,7 +159,7 @@
 				dma-coherent;
 			};
 
-			xor3 at 460000 {
+			xor3: xor at 460000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x460000 0x1000>,
 				      <0x470000 0x1000>;
-- 
2.6.2
