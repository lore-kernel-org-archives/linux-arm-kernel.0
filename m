From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 17 Mar 2017 23:43:41 +0800
Subject: [PATCH 1/3] ARM: sun8i: v3s: add LRADC device node
In-Reply-To: <20170317154343.39921-1-icenowy@aosc.xyz>
References: <20170317154343.39921-1-icenowy@aosc.xyz>
Message-ID: <20170317154343.39921-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features a LRADC like the ones in older SoCs.

Add a device tree node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 71075969e5e6..77bbf5ff9548 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -238,6 +238,13 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.12.0
