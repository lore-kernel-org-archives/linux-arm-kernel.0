From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 25 Oct 2013 18:57:23 +0300
Subject: [PATCHv9 29/43] ARM: dts: DRA7: link in clock DT data
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Message-ID: <1382716658-6964-30-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock tree DT data is now included from base dra7.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..bf7797e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -104,6 +104,8 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
+		/include/ "dra7xx-clocks.dtsi"
+
 		counter32k: counter at 4ae04000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
-- 
1.7.9.5
