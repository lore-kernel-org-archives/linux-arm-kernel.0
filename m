From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:46 -0500
Subject: [PATCH 2/7] ARM: dts: NSP: Correct NAND partition unit address
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND partition unit address does not match the other NSP device tree
files.  This change makes them uniform.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625k.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 98337d6..dc24056 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -80,19 +80,19 @@
 			reg = <0x00000000 0x00200000>;
 			read-only;
 		};
-		partition at 1 {
+		partition at 200000 {
 			label = "nenv";
 			reg = <0x00200000 0x00400000>;
 		};
-		partition at 2 {
+		partition at 600000 {
 			label = "nsystem";
 			reg = <0x00600000 0x00a00000>;
 		};
-		partition at 3 {
+		partition at 1000000 {
 			label = "nrootfs";
 			reg = <0x01000000 0x03000000>;
 		};
-		partition at 4 {
+		partition at 4000000 {
 			label = "ncustfs";
 			reg = <0x04000000 0x3c000000>;
 		};
-- 
2.7.4
