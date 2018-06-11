From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Jun 2018 15:47:12 -0700
Subject: [PATCH 1/3] ARM: dts: NSP: Fix i2c controller interrupt type
In-Reply-To: <20180611224714.7007-1-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
Message-ID: <20180611224714.7007-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controller should use IRQ_TYPE_LEVEL_HIGH instead of
IRQ_TYPE_NONE.

Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index dcc55aa84583..c6aa62386941 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -391,7 +391,7 @@
 			reg = <0x38000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			dma-coherent;
 			status = "disabled";
-- 
2.14.1
