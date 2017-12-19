From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 19 Dec 2017 09:07:47 +0100
Subject: [PATCH v3 6/6] arm: dts: sun8i: h3-h8: ir register size should be the
 whole memory block
In-Reply-To: <20171219080747.4507-1-embed3d@gmail.com>
References: <20171219080747.4507-1-embed3d@gmail.com>
Message-ID: <20171219080747.4507-7-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of the register should be the size of the whole memory block,
not just the registers, that are needed.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 8d40c00d64bb..a9caeda4a574 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -674,7 +674,7 @@
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg = <0x01f02000 0x40>;
+			reg = <0x01f02000 0x400>;
 			status = "disabled";
 		};
 
-- 
2.11.0
