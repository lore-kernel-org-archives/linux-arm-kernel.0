From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:52 +0900
Subject: [PATCH 6/7] ARM: shmobile: Remove __init from
 rcar_gen2_read_mode_pins()
In-Reply-To: <cover.1393400446.git.horms+renesas@verge.net.au>
References: <cover.1393400446.git.horms+renesas@verge.net.au>
Message-ID: <e7509f6eca10cff3933f8a71f4ca9d8be8447ec3.1393400446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove __init from rcar_gen2_read_mode_pins() to allow
it to be used after boot. For instance the R-Car Gen2
MD21 check is needed even in the case of CPU Hotplug.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 69ccc6c..1060448 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -28,7 +28,7 @@
 
 #define MODEMR 0xe6160060
 
-u32 __init rcar_gen2_read_mode_pins(void)
+u32 rcar_gen2_read_mode_pins(void)
 {
 	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
 	u32 mode;
-- 
1.8.5.2
