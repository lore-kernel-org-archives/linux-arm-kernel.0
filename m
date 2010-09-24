From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 23 Sep 2010 22:41:04 -0500
Subject: [PATCH 1/2] OMAP: features: export symbol omap3_features
Message-ID: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Since omap3_features is a global variable, only code
built-in the kernel can make use of it and thus use
omap_has ##feat functions; exporting this as a kernel
symbol makes modules able to use feature detection
framework too.

Thread: http://marc.info/?l=linux-omap&m=128528822902211&w=2

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Nishanth Menon <nm@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
CC: Sanjeev Premi <premi@ti.com>
CC: linux-omap at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-omap2/id.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..a8c6d19 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -31,6 +31,7 @@ static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap3_features;
+EXPORT_SYMBOL(omap3_features);
 
 unsigned int omap_rev(void)
 {
-- 
1.7.1
