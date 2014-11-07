From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  7 Nov 2014 14:38:25 +0100
Subject: [PATCH/RFC 1/2] ARM: shmobile: kzm9g dts: Declare the full 512 MiB of
 RAM
Message-ID: <1415367506-8713-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Traditionally, the first 16 MiB of RAM was reserved for the RT
processor.  However, this is incompatible with CONFIG_AUTO_ZRELADDR=y,
which requires that the start address of physical memory is a multiple
of 128 MiB.

As CONFIG_AUTO_ZRELADDR=y is enabled for multi-platform kernels, declare
RAM to start at 0x40000000.

While at it, reclaim the last 8 MiB of RAM, too, so the full 512 MiB is
available.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Questions:
  - Why was the last 8 MiB of RAM not used?
  - Is it an option to fix CONFIG_AUTO_ZRELADDR instead?

 arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 27c5f426d172f03d..e7dae01933a575f1 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -21,6 +21,6 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x41000000 0x1e800000>;
+		reg = <0x40000000 0x20000000>;
 	};
 };
-- 
1.9.1
