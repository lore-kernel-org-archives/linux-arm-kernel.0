From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:11:14 +0900
Subject: [PATCH 7/7] libata: Remove to support pata for S5PC100
In-Reply-To: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162674-25860-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5PC100, we don't need to support
pata for S5PC100.

Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/ata/pata_samsung_cf.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index c446ae6..5c35f21 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -31,7 +31,6 @@
 
 enum s3c_cpu_type {
 	TYPE_S3C64XX,
-	TYPE_S5PC100,
 	TYPE_S5PV210,
 };
 
@@ -453,10 +452,6 @@ static void pata_s3c_hwinit(struct s3c_ide_info *info,
 		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
 		break;
 
-	case TYPE_S5PC100:
-		pata_s3c_cfg_mode(info->sfr_addr);
-		/* FALLTHROUGH */
-
 	case TYPE_S5PV210:
 		/* Configure as little endian */
 		pata_s3c_set_endian(info->ide_addr, 0);
@@ -538,11 +533,6 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 		info->sfr_addr = info->ide_addr + 0x1800;
 		info->ide_addr += 0x1900;
 		info->fifo_status_reg = 0x94;
-	} else if (cpu_type == TYPE_S5PC100) {
-		ap->ops = &pata_s5p_port_ops;
-		info->sfr_addr = info->ide_addr + 0x1800;
-		info->ide_addr += 0x1900;
-		info->fifo_status_reg = 0x84;
 	} else {
 		ap->ops = &pata_s5p_port_ops;
 		info->fifo_status_reg = 0x84;
@@ -640,9 +630,6 @@ static struct platform_device_id pata_s3c_driver_ids[] = {
 		.name		= "s3c64xx-pata",
 		.driver_data	= TYPE_S3C64XX,
 	}, {
-		.name		= "s5pc100-pata",
-		.driver_data	= TYPE_S5PC100,
-	}, {
 		.name		= "s5pv210-pata",
 		.driver_data	= TYPE_S5PV210,
 	},
-- 
1.7.1
