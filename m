From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 15 Dec 2015 13:36:36 +0000
Subject: [PATCH v2 2/4] arm64: dts: Foundation model: increase GICC region to
 allow EOImode=1
In-Reply-To: <1450186598-24504-1-git-send-email-andre.przywara@arm.com>
References: <1450186598-24504-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1450186598-24504-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Foundation model GIC mapping is wrong, as the GICC region should
be 8kB instead of 4kB (the model implements the GICv2 architecture).
This defect prevents the driver from switching to EOImode==1.

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
