From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Mon,  5 Nov 2018 16:46:51 +0800
Subject: [PATCHv2 4/6] arm64: dts: Add the PCIE EP node in dts
In-Reply-To: <20181105084653.26597-1-xiaowei.bao@nxp.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
Message-ID: <20181105084653.26597-4-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PCIE EP node in dts for ls1046a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - Add the SoC specific compatibles. 

 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   32 ++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 64d334c..544b3e5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -655,6 +655,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep at 3400000 {
+			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+				0x40 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie at 3500000 {
 			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -681,6 +692,17 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3500000 {
+			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+				0x48 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
 		pcie at 3600000 {
 			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -707,6 +729,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3600000 {
+			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+				0x50 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <6>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
 	};
 
 	reserved-memory {
-- 
1.7.1
