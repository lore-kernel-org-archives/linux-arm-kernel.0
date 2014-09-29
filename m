From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 29 Sep 2014 17:38:19 +0300
Subject: [PATCH v1 4/4] ARM: dts: k2hk-evm: attach net,
 qmss and knav_dmas to keystone-gpc
In-Reply-To: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1412001499-19369-5-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attach Keystone 2s nodes for NetCP, NetCPx, QMSS, KNAV-DMA devices
to the TI Keystone 2 Generic PM Controller.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 91371f7..c1ceaa2 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -58,6 +58,7 @@
 				clock-output-names = "refclk-ddr3b";
 			};
 		};
+
 		qmss: qmss at 2a40000 {
 			compatible = "ti,keystone-navigator-qmss";
 			dma-coherent;
@@ -65,6 +66,8 @@
 			#size-cells = <1>;
 			clocks = <&chipclk13>;
 			ranges;
+			power-domains = <&pm_controller>;
+
 			queue-range	= <0 0x4000>;
 			linkram0	= <0x100000 0x8000>;
 			linkram1	= <0x0 0x10000>;
@@ -198,6 +201,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
+
 			ti,navigator-cloud-address = <0x23a80000 0x23a90000
 						   0x23aa0000 0x23ab0000>;
 
@@ -229,6 +234,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
 
 			clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
 			dma-coherent;
@@ -307,6 +313,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			power-domains = <&pm_controller>;
 
 			clocks = <&clkxge>;
 			clock-names = "clk_xge";
-- 
1.9.1
