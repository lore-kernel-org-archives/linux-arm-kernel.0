From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 00:24:55 +0800
Subject: [PATCH 1/3] ARM: dts: sun8i: Enable timer node for A83T
In-Reply-To: <1452961497-10804-1-git-send-email-wens@csie.org>
References: <1452961497-10804-1-git-send-email-wens@csie.org>
Message-ID: <1452961497-10804-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vishnu Patekar <vishnupatekar0510@gmail.com>

A83T timer is compatible with that of earlier SOCs.
Just add timer node to enable and re-use it.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index bad5df7175b4..08df5598df9c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -174,6 +174,14 @@
 			};
 		};
 
+		timer at 01c20c00 {
+			compatible = "allwinner,sun4i-a10-timer";
+			reg = <0x01c20c00 0xa0>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.0.rc3
