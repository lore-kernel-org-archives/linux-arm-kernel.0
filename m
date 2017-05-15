From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 16:39:59 +0800
Subject: [PATCH 2/4] ARM: sun8i: v3s: add LRADC device node
In-Reply-To: <20170515084001.63123-1-icenowy@aosc.io>
References: <20170515084001.63123-1-icenowy@aosc.io>
Message-ID: <20170515084001.63123-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features a LRADC like the ones in older SoCs.

Add a device tree node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3b50fa580261..b9a3df941fb4 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -240,6 +240,13 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		lradc: lradc at 1c22800 {
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
2.12.2
