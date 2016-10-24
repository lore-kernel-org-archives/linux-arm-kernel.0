From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 24 Oct 2016 17:09:50 +0200
Subject: [PATCH] ARM64: dts: bcm2835: Fix bcm2837 compatible string
Message-ID: <1477321791-7896-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2837-rpi-3-b.dts, its only in-tree user, was overriding it as
"brcm,bcm2837" already.

Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")
Cc: Eric Anholt <eric@anholt.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index 8216bbb29fe0..c1f719b7097a 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -1,7 +1,7 @@
 #include "bcm283x.dtsi"
 
 / {
-	compatible = "brcm,bcm2836";
+	compatible = "brcm,bcm2837";
 
 	soc {
 		ranges = <0x7e000000 0x3f000000 0x1000000>,
-- 
2.6.6
