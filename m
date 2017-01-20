From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 20 Jan 2017 12:22:03 +0100
Subject: [PATCH v5 12/14] ARM: davinci: remove BUG_ON() from
 da850_register_sata()
In-Reply-To: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484911325-23425-13-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahci driver now supports other refclk clock rates.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index cfceb32..7cf529f 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1080,9 +1080,6 @@ int __init da850_register_sata(unsigned long refclkpn)
 {
 	int ret;
 
-	/* please see comment in drivers/ata/ahci_da850.c */
-	BUG_ON(refclkpn != 100 * 1000 * 1000);
-
 	ret = da850_register_sata_refclk(refclkpn);
 	if (ret)
 		return ret;
-- 
2.9.3
