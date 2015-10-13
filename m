From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 13 Oct 2015 10:37:47 +0100
Subject: [PATCH 2/4] arm64: dts: Foundation model: increate GICC region to
 allow EOImode=1
In-Reply-To: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
References: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1444729069-27922-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent commits made the GIC driver use EOImode=1 for all GICs
that advertise the proper GICC region size.
To let the model benefit from the blessings of that mode, increase
the GICC region to its actual size of 8K.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 3c5595d..57ad9fe 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -78,7 +78,7 @@
 		#address-cells = <2>;
 		interrupt-controller;
 		reg = <0x0 0x2c001000 0 0x1000>,
-		      <0x0 0x2c002000 0 0x1000>,
+		      <0x0 0x2c002000 0 0x2000>,
 		      <0x0 0x2c004000 0 0x2000>,
 		      <0x0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-- 
2.5.1
