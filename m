From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed,  8 Oct 2014 10:19:57 +0800
Subject: [PATCH v2 3/3] ARM: dts: rk3288: add VOP iommu nodes
In-Reply-To: <1412734798-11116-1-git-send-email-djkurtz@chromium.org>
References: <1412734798-11116-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1412734798-11116-4-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the VOP iommus.
Device nodes for other iommus will be added in later patches.

The iommu nodes use the #iommu-cells property as described in:
  Documentation/devicetree/bindings/iommu/iommu.txt

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..cbc92fa 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -271,6 +271,24 @@
 		status = "disabled";
 	};
 
+	vopb_mmu: iommu at 0xff930300 {
+		compatible = "rockchip,iommu";
+		reg = <0xff930300 0x100>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopb_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vopl_mmu: iommu at 0xff940300 {
+		compatible = "rockchip,iommu";
+		reg = <0xff940300 0x100>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.1.0.rc2.206.gedb03e5
