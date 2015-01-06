From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  6 Jan 2015 20:17:39 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: kzm9g-reference dts: Declare the full
 512 MiB of RAM
In-Reply-To: <1420571859-11655-1-git-send-email-geert+renesas@glider.be>
References: <1420571859-11655-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1420571859-11655-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Traditionally, the first 16 MiB of RAM was reserved for the RT
processor.  However, this is incompatible with CONFIG_AUTO_ZRELADDR=y,
which requires that the start address of physical memory is a multiple
of 128 MiB.

As CONFIG_AUTO_ZRELADDR=y is enabled for multi-platform kernels, declare
RAM to start at 0x40000000.

While at it, reclaim the last 8 MiB of RAM, too, so the full 512 MiB is
available. Note that kzm9g_defconfig still has
CONFIG_MEMORY_START=0x41000000 and CONFIG_MEMORY_SIZE=0x1f000000, so
before the advent of DT we scribbled over the last 8 MiB, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC status,
  - We now know the last 8 MiB of RAM is _not_ used for a U-Boot
    splash screen.
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 6d32c87632d42fda..b6c292f839584343 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -45,7 +45,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x41000000 0x1e800000>;
+		reg = <0x40000000 0x20000000>;
 	};
 
 	reg_1p8v: regulator at 0 {
-- 
1.9.1
