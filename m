From: marex@denx.de (Marek Vasut)
Date: Thu,  4 Oct 2018 00:54:36 +0200
Subject: [PATCH] ARM: dts: socfpga: Add FPGA manager GPIO binding
Message-ID: <20181003225436.21793-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio-syscon binding to export the GPIO pins accessible via the
FPGA manager GPIO block.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 1835a824c9b9..b77c96bc445c 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -557,6 +557,13 @@
 			interrupts = <0 175 4>;
 		};
 
+		fpgamgr_gpio: gpio at ff706010 {
+			compatible = "altr,fpga-mgr-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&fpgamgr0 0x4>;
+		};
+
 		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-- 
2.18.0
