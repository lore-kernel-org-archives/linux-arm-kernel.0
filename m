From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:13:56 +0000
Subject: [PATCH 05/44] ARM: l2c: tidy up l2x0_of_data declarations
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBk-0002c3-DI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove NULL initialisers, make these all __initconst structures, and
order their members in the same order as the structure declaration.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ac410b21edfb..063e1787e8c3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -873,49 +873,48 @@ static void __init aurora_of_setup(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
-static const struct l2x0_of_data pl310_data = {
+static const struct l2x0_of_data pl310_data __initconst = {
 	.setup = pl310_of_setup,
 	.save  = pl310_save,
 	.outer_cache = {
-		.resume      = pl310_resume,
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
 		.flush_range = l2x0_flush_range,
-		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = pl310_resume,
 	},
 };
 
-static const struct l2x0_of_data l2x0_data = {
+static const struct l2x0_of_data l2x0_data __initconst = {
 	.setup = l2x0_of_setup,
-	.save  = NULL,
 	.outer_cache = {
-		.resume      = l2x0_resume,
 		.inv_range   = l2x0_inv_range,
 		.clean_range = l2x0_clean_range,
 		.flush_range = l2x0_flush_range,
-		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = l2x0_resume,
 	},
 };
 
-static const struct l2x0_of_data aurora_with_outer_data = {
+static const struct l2x0_of_data aurora_with_outer_data __initconst = {
 	.setup = aurora_of_setup,
 	.save  = aurora_save,
 	.outer_cache = {
-		.resume      = aurora_resume,
 		.inv_range   = aurora_inv_range,
 		.clean_range = aurora_clean_range,
 		.flush_range = aurora_flush_range,
-		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = aurora_resume,
 	},
 };
 
-static const struct l2x0_of_data aurora_no_outer_data = {
+static const struct l2x0_of_data aurora_no_outer_data __initconst = {
 	.setup = aurora_of_setup,
 	.save  = aurora_save,
 	.outer_cache = {
@@ -923,8 +922,7 @@ static const struct l2x0_of_data aurora_no_outer_data = {
 	},
 };
 
-static const struct l2x0_of_data tauros3_data = {
-	.setup = NULL,
+static const struct l2x0_of_data tauros3_data __initconst = {
 	.save  = tauros3_save,
 	/* Tauros3 broadcasts L1 cache operations to L2 */
 	.outer_cache = {
@@ -932,17 +930,17 @@ static const struct l2x0_of_data tauros3_data = {
 	},
 };
 
-static const struct l2x0_of_data bcm_l2x0_data = {
+static const struct l2x0_of_data bcm_l2x0_data __initconst = {
 	.setup = pl310_of_setup,
 	.save  = pl310_save,
 	.outer_cache = {
-		.resume      = pl310_resume,
 		.inv_range   = bcm_inv_range,
 		.clean_range = bcm_clean_range,
 		.flush_range = bcm_flush_range,
-		.sync        = l2x0_cache_sync,
 		.flush_all   = l2x0_flush_all,
 		.disable     = l2x0_disable,
+		.sync        = l2x0_cache_sync,
+		.resume      = pl310_resume,
 	},
 };
 
-- 
1.8.3.1
