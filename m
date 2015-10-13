From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Tue, 13 Oct 2015 14:38:59 -0500
Subject: [PATCH v2] ARM: socfpga: dts: add fpga manager
Message-ID: <1444765139-2040-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Add FPGA manager to device tree for SoCFPGA.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
v2: Remove 0x after @
    No caps in hex numbers
    renamed hps_0_fpgamgr to fpgamgr0
    move node to be in alpha order by node name
---
 arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 314e589..0f50ae8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -513,6 +513,13 @@
 				};
 		};
 
+		fpgamgr0: fpgamgr at ff706000 {
+			compatible = "altr,socfpga-fpga-mgr";
+			reg = <0xff706000 0x1000
+			       0xffb90000 0x1000>;
+			interrupts = <0 175 4>;
+		};
+
 		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-- 
1.9.1
