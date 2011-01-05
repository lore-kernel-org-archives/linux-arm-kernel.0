From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Jan 2011 14:06:33 +0000
Subject: [PATCH 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
References: <1294236400-22477-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1294236400-22477-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the process of moving platforms away from integrator-flash
(aka armflash), add optionnal probing for the AFS partition type.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/maps/physmap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index 4c18b98..221354d 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -79,7 +79,11 @@ static const char *rom_probe_types[] = {
 					"map_rom",
 					NULL };
 #ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
+static const char *part_probe_types[] = { "cmdlinepart", "RedBoot",
+#ifdef CONFIG_MTD_AFS_PARTS
+					  "afs",
+#endif
+					  NULL };
 #endif
 
 static int physmap_flash_probe(struct platform_device *dev)
-- 
1.7.0.4
