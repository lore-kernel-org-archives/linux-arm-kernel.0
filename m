From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:22:56 -0600
Subject: [PATCH 4/4] ARM: dts: OMAP5: Add IOMMU nodes
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315776-33197-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU DT nodes have been added for the DSP and IPU
subsystems. The MMUs in OMAP5 are identical to those in
OMAP4, including the bus error back capability on IPU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..a78fdaa 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -513,6 +513,23 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu at 4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0xff>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+			dma-window = <0x20000000 0xdffff000>;
+		};
+
+		mmu_ipu: mmu at 55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0xff>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu";
+			dma-window = <0 0xdffff000>;
+			ti,iommu-bus-err-back;
+		};
+
 		keypad: keypad at 4ae1c000 {
 			compatible = "ti,omap4-keypad";
 			reg = <0x4ae1c000 0x400>;
-- 
1.8.5.3
