From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 2 Oct 2018 16:20:35 +0300
Subject: [PATCH 1/4] ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
In-Reply-To: <20181002132038.27189-1-tudor.ambarus@microchip.com>
References: <20181002132038.27189-1-tudor.ambarus@microchip.com>
Message-ID: <20181002132038.27189-2-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The offsets for the bootloader environment and its redundant partition
were inverted. Fix the addresses to match our nand flash map available at:

http://www.at91.com/linux4sam/pub/Linux4SAM/SambaSubsections//demo_nandflash_map_lnx4sam5x.png

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index b10dccd0958f..bb08f8344128 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -91,13 +91,13 @@
 							reg = <0x40000 0xc0000>;
 						};
 
-						bootloaderenv at 0x100000 {
-							label = "bootloader env";
+						bootloaderenvred at 0x100000 {
+							label = "bootloader env redundant";
 							reg = <0x100000 0x40000>;
 						};
 
-						bootloaderenvred at 0x140000 {
-							label = "bootloader env redundant";
+						bootloaderenv at 0x140000 {
+							label = "bootloader env";
 							reg = <0x140000 0x40000>;
 						};
 
-- 
2.9.4
