From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 17 Jan 2017 17:32:38 +0800
Subject: [PATCH v3 4/9] arm: dts: ls1021a: share all MSIs
In-Reply-To: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1484645563-29877-5-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to maximize the use of MSI, a PCIe controller will share
all MSI controllers. The patch changes msi-parent to refer to all
MSI controller dts nodes.

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
v3-v1:
- None

 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 6651938..1c82024 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -723,7 +723,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi1>;
+			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
@@ -746,7 +746,7 @@
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&msi2>;
+			msi-parent = <&msi1>, <&msi2>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
