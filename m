From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 2 Oct 2018 16:20:37 +0300
Subject: [PATCH 3/4] ARM: dts: at91: sama5d3_xplained: even nand memory
 partitions
In-Reply-To: <20181002132038.27189-1-tudor.ambarus@microchip.com>
References: <20181002132038.27189-1-tudor.ambarus@microchip.com>
Message-ID: <20181002132038.27189-4-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sama5d3_xplained, sam9x5cm, sama5d2_ptc_ek and sama5d4_xplained nand
flashes have a common memory map. Even the nand memory partitions to
match our nand flash map available at:

http://www.at91.com/linux4sam/pub/Linux4SAM/SambaSubsections//demo_nandflash_map_lnx4sam5x.png

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 02c1d2958d78..322a744e4363 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -297,12 +297,17 @@
 
 						bootloader at 40000 {
 							label = "bootloader";
-							reg = <0x40000 0x80000>;
+							reg = <0x40000 0xc0000>;
 						};
 
-						bootloaderenv at c0000 {
+						bootloaderenvred at 100000 {
+							label = "bootloader env redundant";
+							reg = <0x100000 0x40000>;
+						};
+
+						bootloaderenv at 140000 {
 							label = "bootloader env";
-							reg = <0xc0000 0xc0000>;
+							reg = <0x140000 0x40000>;
 						};
 
 						dtb at 180000 {
-- 
2.9.4
