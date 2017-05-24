From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 24 May 2017 21:06:52 +0200
Subject: [PATCH 11/11] ARM: sun5i: add a cryptographic engine node
In-Reply-To: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
References: <20170524190652.13278-1-antoine.tenart@free-electrons.com>
Message-ID: <20170524190652.13278-12-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the cryptographic engine that can be found on sun5i SoCs.
This cryptographic engine is compatible with the Allwinner cryptographic
accelerator driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 5175f9cc9bed..9bfefa2c7224 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -355,6 +355,14 @@
 			status = "disabled";
 		};
 
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun4i-a10-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <54>;
+			clocks = <&ccu CLK_AHB_SS>, <&ccu CLK_SS>;
+			clock-names = "ahb", "mod";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-- 
2.9.4
