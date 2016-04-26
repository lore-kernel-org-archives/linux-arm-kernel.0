From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:31 +0200
Subject: [PATCH v3 03/11] arm64: dts: marvell: rename armada-ap806 XOR nodes
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Node names should not contain an instance number, the unit address
serves to distinguish nodes of the same name. So rename the XOR nodes
to just xor@<address>.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
[Thomas:
 - remove labels, they are really not needed for XOR engines.
 - remove the Fixes: tag, as this is not a fix.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 3ecf9b1..ca42c36 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -135,7 +135,7 @@
 				marvell,spi-base = <128>, <136>, <144>, <152>;
 			};
 
-			xor0 at 400000 {
+			xor at 400000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x400000 0x1000>,
 				      <0x410000 0x1000>;
@@ -143,7 +143,7 @@
 				dma-coherent;
 			};
 
-			xor1 at 420000 {
+			xor at 420000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x420000 0x1000>,
 				      <0x430000 0x1000>;
@@ -151,7 +151,7 @@
 				dma-coherent;
 			};
 
-			xor2 at 440000 {
+			xor at 440000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x440000 0x1000>,
 				      <0x450000 0x1000>;
@@ -159,7 +159,7 @@
 				dma-coherent;
 			};
 
-			xor3 at 460000 {
+			xor at 460000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x460000 0x1000>,
 				      <0x470000 0x1000>;
-- 
2.6.4
