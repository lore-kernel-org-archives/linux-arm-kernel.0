From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:29 -0600
Subject: [PATCH 07/12] ARM: dts: socfpga: add fpga-manager node for Arria10
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-8-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the FPGA manger DTS entry for Arria10.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 551c636..3ceb4e4 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -512,6 +512,15 @@
 			};
 		};
 
+		fpga_mgr: fpga-mgr at ffd03000 {
+			compatible = "altr,socfpga-a10-fpga-mgr";
+			reg = <0xffd03000 0x100
+			       0xffcfe400 0x20>;
+			clocks = <&l4_mp_clk>;
+			resets = <&rst FPGAMGR_RESET>;
+			reset-names = "fpgamgr";
+		};
+
 		i2c0: i2c at ffc02200 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
