From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 16:41 +0100
Subject: [PATCH] ata: sata_highbank: remove superfluous cast
Message-ID: <11638294.fp3ZK6zVlg@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hpriv->plat_data is 'void *' so there is no need to cast it to
'struct ecx_plat_data *'.

Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_highbank.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/sata_highbank.c
===================================================================
--- a/drivers/ata/sata_highbank.c	2014-03-14 16:45:04.384724376 +0100
+++ b/drivers/ata/sata_highbank.c	2014-03-26 16:28:40.927062349 +0100
@@ -141,7 +141,7 @@ static ssize_t ecx_transmit_led_message(
 					ssize_t size)
 {
 	struct ahci_host_priv *hpriv =  ap->host->private_data;
-	struct ecx_plat_data *pdata = (struct ecx_plat_data *) hpriv->plat_data;
+	struct ecx_plat_data *pdata = hpriv->plat_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	unsigned long flags;
 	int pmp, i;
