From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:08:57 +0200
Subject: [PATCH 1/2] arm64: zynqmp: Remove leading 0s from mtd table for spi
 flashes
Message-ID: <26db4d8bc7cbcf95d2a60366e36c839ab3b5d6d9.1500552534.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warnings:
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning
(unit_address_format): Node
/amba/spi at ff040000/spi0_flash0 at 0/spi0_flash0 at 00000000 unit name should
not have leading 0s
arch/arm64/boot/dts/xilinx/zynqmp-ep108.dtb: Warning
(unit_address_format): Node
/amba/spi at ff050000/spi1_flash0 at 0/spi1_flash0 at 00000000 unit name should
not have leading 0s

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index ef1b9e573af0..ee7fa27e1e23 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -92,7 +92,7 @@
 		spi-max-frequency = <50000000>;
 		reg = <0>;
 
-		spi0_flash0 at 00000000 {
+		spi0_flash0 at 0 {
 			label = "spi0_flash0";
 			reg = <0x0 0x100000>;
 		};
@@ -109,7 +109,7 @@
 		spi-max-frequency = <50000000>;
 		reg = <0>;
 
-		spi1_flash0 at 00000000 {
+		spi1_flash0 at 0 {
 			label = "spi1_flash0";
 			reg = <0x0 0x100000>;
 		};
-- 
1.9.1
