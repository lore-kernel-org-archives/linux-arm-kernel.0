From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Fri, 23 Dec 2016 13:52:13 +0100
Subject: [PATCH 1/1] ARM64: dts: meson-gxbb-odroidc2: linux,usable-memory
Message-ID: <20161223125213.5461-1-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After reading the fdt u-boot overwrites the reg property of the
memory node with <0x0 0x0 0x0 0x78000000>.

To override this setting we have to use the property
linux,usable-memory.

If the first 16MB of the 2GB physical memory are used by
the Linux kernel oops occur on the Odroid C2.

For the Odroid C2 this patch replaces
[RFT PATCH] ARM64: dts: meson-gxbb: Add reserved memory zone and
usable memory range
https://lkml.org/lkml/2016/12/12/127

Fixes: 855960342d1e7 ARM64: dts: amlogic: add Hardkernel ODROID-C2
CC: Neil Armstrong <narmstrong@baylibre.com>
CC: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 238fbeacd330..82ab94417940 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -61,7 +61,7 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
+		linux,usable-memory = <0x0 0x01000000 0x0 0x7f000000>;
 	};
 
 	usb_otg_pwr: regulator-usb-pwrs {
-- 
2.11.0
