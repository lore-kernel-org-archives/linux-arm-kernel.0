From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed,  4 May 2016 12:43:55 -0500
Subject: [PATCH] ARM: dts: dra7: Add gpmc dma channel
Message-ID: <1462383835-10839-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dma channel information to the gpmc.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This patch is based on top of linux-next where EDMA support for DRA7 has
been added.

 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e007401..3a8f397 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1451,6 +1451,8 @@
 			ti,hwmods = "gpmc";
 			reg = <0x50000000 0x37c>;      /* device IO registers */
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&edma_xbar 4 0>;
+			dma-names = "rxtx";
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
-- 
2.7.0
