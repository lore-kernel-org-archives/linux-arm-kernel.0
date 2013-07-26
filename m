From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 26 Jul 2013 10:17:53 -0300
Subject: [PATCH v9 16/30] bus: mvebu-mbus: Factorize Armada 370/XP data
 structures
In-Reply-To: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374844687-19981-17-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

These structures were only different in the mapping tables.
Now that those tables have been removed, it doesn't make any sense
to keep different structures.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/bus/mvebu-mbus.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 26af145..19ab6ff 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -536,15 +536,7 @@ mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 	mvebu_mbus_dram_info.num_cs = cs;
 }
 
-static const struct mvebu_mbus_soc_data armada_370_mbus_data = {
-	.num_wins            = 20,
-	.num_remappable_wins = 8,
-	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
-	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
-	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-};
-
-static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
+static const struct mvebu_mbus_soc_data armada_370_xp_mbus_data = {
 	.num_wins            = 20,
 	.num_remappable_wins = 8,
 	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
@@ -604,9 +596,9 @@ static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
  */
 static const struct of_device_id of_mvebu_mbus_ids[] = {
 	{ .compatible = "marvell,armada370-mbus",
-	  .data = &armada_370_mbus_data, },
+	  .data = &armada_370_xp_mbus_data, },
 	{ .compatible = "marvell,armadaxp-mbus",
-	  .data = &armada_xp_mbus_data, },
+	  .data = &armada_370_xp_mbus_data, },
 	{ .compatible = "marvell,kirkwood-mbus",
 	  .data = &kirkwood_mbus_data, },
 	{ .compatible = "marvell,dove-mbus",
-- 
1.8.1.5
