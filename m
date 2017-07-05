From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 5 Jul 2017 14:58:58 +0800
Subject: [PATCHv4 4/9] arm: dts: ls1021a: share all MSIs
In-Reply-To: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499237943-24203-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1499237943-24203-4-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minghuan Lian <Minghuan.Lian@nxp.com>

In order to maximize the use of MSI, a PCIe controller will share
all MSI controllers. The patch changes msi-parent to refer to all
MSI controller dts nodes.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
v4-v1:
 - None

 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 51b0f69..9319e1f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -699,7 +699,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi1>;
+			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
@@ -722,7 +722,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi2>;
+			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
-- 
2.1.0.27.g96db324
