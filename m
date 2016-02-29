From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  1 Mar 2016 00:44:24 +0100
Subject: [PATCH 7/8] ARM64: dts: amlogic: Extend GXBaby GIC node
In-Reply-To: <1456789465-2962-1-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
Message-ID: <1456789465-2962-8-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GICH and GICV resources for HYP mode - guess based on other vendors.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 0ae089bd1806..5088ae3ff653 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -117,7 +117,9 @@
 		gic: interrupt-controller at c4301000 {
 			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 			reg = <0x0 0xc4301000 0 0x1000>,
-			      <0x0 0xc4302000 0 0x0100>;
+			      <0x0 0xc4302000 0 0x0100>,
+			      <0x0 0xc4304000 0 0x2000>,
+			      <0x0 0xc4306000 0 0x2000>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9
 				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-- 
2.6.2
