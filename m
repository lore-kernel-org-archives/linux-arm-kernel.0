From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Dec 2016 21:13:51 +0100
Subject: [PATCH] ARM: dts: vexpress: Support GICC_DIR operations
Message-ID: <20161210201351.25894-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv2 CPU interface registers span across 8K, not 4K as indicated in
the DT.  Only the GICC_DIR register is located after the initial 4K
boundary, leaving a functional system but without support for separately
EOI'ing and deactivating interrupts.

After this change the system support split priority drop and interrupt
deactivation.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 0205c97..2e0cf39 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -126,7 +126,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0x2c001000 0 0x1000>,
-		      <0 0x2c002000 0 0x1000>,
+		      <0 0x2c002000 0 0x2000>,
 		      <0 0x2c004000 0 0x2000>,
 		      <0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-- 
2.9.0
