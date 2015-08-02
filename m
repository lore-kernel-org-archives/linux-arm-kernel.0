From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Aug 2015 23:43:12 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: set correct dwc2 params for cortex-a9
 socs
Message-ID: <1617149.AMXNNUATDo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the manual, the fifo sizes are the same as on later socs
like the rk3288 and this also fixes an error about "insufficient fifo
memory", as it seems the values read from the ip are wrong.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index a2ae9f3..c571ac8 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -172,6 +172,11 @@
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <275>;
+		g-tx-fifo-size = <256 128 128 64 64 32>;
+		g-use-dma;
 		status = "disabled";
 	};
 
@@ -181,6 +186,7 @@
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG1>;
 		clock-names = "otg";
+		dr_mode = "host";
 		status = "disabled";
 	};
 
-- 
2.1.4
