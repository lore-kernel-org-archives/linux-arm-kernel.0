From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat,  9 Feb 2013 13:38:16 -0300
Subject: [PATCH 7/7] ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with
 dev_warn()
In-Reply-To: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360427896-12004-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the condition is not an error but a warning, replace
printk KERN_ERR with dev_warn.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 4771945..fd6e35b 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -367,7 +367,7 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 
 	if (cpu_is_omap24xx() &&
 			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
-		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
+		dev_warn(dev, "OneNAND using only SYNC_READ on 24xx\n");
 		gpmc_onenand_data->flags &= ~ONENAND_SYNC_READWRITE;
 		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 	}
-- 
1.7.8.6
