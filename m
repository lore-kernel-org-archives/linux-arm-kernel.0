From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 13 Jun 2017 16:45:48 +0300
Subject: [PATCH 1/3] ARM: dts: omap4: add aes2 instance
In-Reply-To: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
References: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
Message-ID: <1497361550-4735-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has AES2 instance, so add its integration data under DT.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 589690e..00e7656 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -909,6 +909,15 @@
 			dma-names = "tx", "rx";
 		};
 
+		aes2: aes at 4b701000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes2";
+			reg = <0x4b701000 0xa0>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 114>, <&sdma 113>;
+			dma-names = "tx", "rx";
+		};
+
 		des: des at 480a5000 {
 			compatible = "ti,omap4-des";
 			ti,hwmods = "des";
-- 
1.9.1
