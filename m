From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Aug 2015 17:54:34 +0800
Subject: [PATCH 1/6] ARM: dts: sun6i: Add lradc node
In-Reply-To: <1440755679-8266-1-git-send-email-wens@csie.org>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
Message-ID: <1440755679-8266-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun6i also has the LRADC for tablet buttons.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 54bb83b58f42..431c7c884e1c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -768,6 +768,13 @@
 			reg = <0x01c20ca0 0x20>;
 		};
 
+		lradc: lradc at 01c22800 {
+			compatible = "allwinner,sun4i-a10-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		rtp: rtp at 01c25000 {
 			compatible = "allwinner,sun6i-a31-ts";
 			reg = <0x01c25000 0x100>;
-- 
2.5.0
