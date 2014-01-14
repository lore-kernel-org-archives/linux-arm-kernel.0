From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 14 Jan 2014 20:04:39 +0100
Subject: [PATCH v3 1/3] ata: sata_mv: introduce compatible string "marvell,
 armada-370-sata"
In-Reply-To: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
References: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1389726281-8731-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sata_mv driver supports the SATA IP found in several Marvell SoCs.
As some new SATA registers have been introduced with the Armada 370/XP
SoCs, a way to identify them is needed.

This patch introduces a new compatible string for the SATA IP found in
Armada 370/XP SoCs.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>
Cc: stable at vger.kernel.org # v3.6+
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
Changes since v2:
- Use compatible string "marvell,armada-370-sata" instead of
  "marvell,armada-370-xp-sata".

 Documentation/devicetree/bindings/ata/marvell.txt | 2 +-
 drivers/ata/sata_mv.c                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
index b5cdd20cde9c..1c8351604d38 100644
--- a/Documentation/devicetree/bindings/ata/marvell.txt
+++ b/Documentation/devicetree/bindings/ata/marvell.txt
@@ -1,7 +1,7 @@
 * Marvell Orion SATA
 
 Required Properties:
-- compatibility : "marvell,orion-sata"
+- compatibility : "marvell,orion-sata" or "marvell,armada-370-sata"
 - reg           : Address range of controller
 - interrupts    : Interrupt controller is using
 - nr-ports      : Number of SATA ports in use.
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 56be31819897..4ec5368c10f7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4209,6 +4209,7 @@ static int mv_platform_resume(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static struct of_device_id mv_sata_dt_ids[] = {
+	{ .compatible = "marvell,armada-370-sata", },
 	{ .compatible = "marvell,orion-sata", },
 	{},
 };
-- 
1.8.5.2
