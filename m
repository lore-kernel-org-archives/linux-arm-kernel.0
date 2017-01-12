From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 12 Jan 2017 10:50:10 -0500
Subject: [PATCH] ARM: dts: NSP: Fix DT ranges error
Message-ID: <1484236210-16067-1-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The range size for axi is 0x2 bytes too small, as the QSPI needs
0x11c408 + 0x004 (which is 0x0011c40c, not 0x0011c40a).  No errors have
been observed with this shortcoming, but fixing it for correctness.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 6c58c78..832795b 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -160,7 +160,7 @@
 
 	axi {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0x18000000 0x0011c40a>;
+		ranges = <0x00000000 0x18000000 0x0011c40c>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.7.4
