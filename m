From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 5 Jul 2017 14:58:59 +0800
Subject: [PATCHv4 5/9] arm64: dts: ls1043a: share all MSIs
In-Reply-To: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1499237943-24203-5-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minghuan Lian <Minghuan.Lian@nxp.com>

In order to maximize the use of MSI, a PCIe controller will share
all MSI controllers. The patch changes "msi-parent" to refer to all
MSI controller dts nodes.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
v4-v1:
 - None

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7ff98f4..d16b9cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -689,7 +689,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi1>;
+			msi-parent = <&msi1>, <&msi2>, <&msi3>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
@@ -714,7 +714,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi2>;
+			msi-parent = <&msi1>, <&msi2>, <&msi3>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 120  0x4>,
@@ -739,7 +739,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi3>;
+			msi-parent = <&msi1>, <&msi2>, <&msi3>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 154 0x4>,
-- 
2.1.0.27.g96db324
