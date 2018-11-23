From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:51 +0100
Subject: [PATCH 2/7] ata: ahci: mvebu: remove stale comment
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Message-ID: <20181123101556.29888-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Armada-38x (32-bit) SoCs, PM platform support has been added since:
commit 32f9494c9dfd ("ARM: mvebu: prepare pm-board.c for the
                      introduction of Armada 38x support")
commit 3cbd6a6ca81c ("ARM: mvebu: Add standby support")

For Armada 64-bit SoCs, like the A3700 also using this AHCI driver, PM
platform support has always existed.

There are even suspend/resume hooks in this driver since:
commit d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")

Remove the stale comment at the end of this driver stating that all
the above does not exist yet.

Fixes: d6ecf15814888 ("ata: ahci_mvebu: add suspend/resume support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index f9cb51be38eb..128d6f22926d 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -197,11 +197,6 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 
-/*
- * We currently don't provide power management related operations,
- * since there is no suspend/resume support at the platform level for
- * Armada 38x for the moment.
- */
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
 	.remove = ata_platform_remove_one,
-- 
2.19.1
