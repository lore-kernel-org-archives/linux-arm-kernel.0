From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 13 Jun 2017 16:45:49 +0300
Subject: [PATCH 2/3] ARM: dts: omap4: add SHAM node
In-Reply-To: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
References: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
Message-ID: <1497361550-4735-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SHAM crypto accelerator.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 00e7656..64d00f5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -927,6 +927,15 @@
 			dma-names = "tx", "rx";
 		};
 
+		sham: sham at 4b100000 {
+			compatible = "ti,omap4-sham";
+			ti,hwmods = "sham";
+			reg = <0x4b100000 0x300>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 119>;
+			dma-names = "rx";
+		};
+
 		abb_mpu: regulator-abb-mpu {
 			compatible = "ti,abb-v2";
 			regulator-name = "abb_mpu";
-- 
1.9.1
