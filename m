From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:06 +0200
Subject: [PATCH 03/11] ARM: cache-l2x0: add a const qualifier
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-5-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change the
following warning would occur:

	arch/arm/mm/cache-l2x0.c: In function 'l2x0_of_init':
	arch/arm/mm/cache-l2x0.c:573:7: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

though.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2a8e380..577baf7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -554,7 +554,7 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
 	struct device_node *np;
-	struct l2x0_of_data *data;
+	const struct l2x0_of_data *data;
 	struct resource res;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
-- 
1.7.10.4
