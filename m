From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 2 Oct 2018 16:20:36 +0300
Subject: [PATCH 2/4] ARM: dts: at91: at91sam9x5cm: even nand memory partitions
In-Reply-To: <20181002132038.27189-1-tudor.ambarus@microchip.com>
References: <20181002132038.27189-1-tudor.ambarus@microchip.com>
Message-ID: <20181002132038.27189-3-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sam9x5cm, sama5d2_ptc_ek, sama5d3_xplained and sama5d4_xplained nand
flashes have a common memory map. Even the nand memory partitions to
match our nand flash map available at:

http://www.at91.com/linux4sam/pub/Linux4SAM/SambaSubsections//demo_nandflash_map_lnx4sam5x.png

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91sam9x5cm.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 993eabe1cf7a..c4cc9cc945fa 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -85,12 +85,22 @@
 
 						uboot at 40000 {
 							label = "u-boot";
-							reg = <0x40000 0x80000>;
+							reg = <0x40000 0xc0000>;
 						};
 
-						ubootenv at c0000 {
+						ubootenvred at 100000 {
+							label = "U-Boot Env Redundant";
+							reg = <0x100000 0x40000>;
+						};
+
+						ubootenv at 140000 {
 							label = "U-Boot Env";
-							reg = <0xc0000 0x140000>;
+							reg = <0x140000 0x40000>;
+						};
+
+						dtb at 180000 {
+							label = "device tree";
+							reg = <0x180000 0x80000>;
 						};
 
 						kernel at 200000 {
-- 
2.9.4
