From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 27 Feb 2014 14:06:19 +0800
Subject: [PATCH 2/3] ARM: dts: vf610: i2c: Add eDMA support
Message-ID: <1393481179-22187-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2c dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 91a7757..9d14a19 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -273,6 +273,9 @@
 				interrupts =<0 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_I2C0>;
 				clock-names = "ipg";
+				dmas = <&edma0 0 50>,
+					<&edma0 0 51>;
+				dma-names = "rx","tx";
 				status = "disabled";
 			};
 
-- 
1.8.4
