From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:19 +0200
Subject: [PATCH 14/25] powerpc/83xx: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	arch/powerpc/platforms/83xx/suspend.c: In function 'pmc_probe':
	arch/powerpc/platforms/83xx/suspend.c:336:7: error: assignment discards 'const' qualifier from pointer target type [-Werror]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/platforms/83xx/suspend.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 1a04671..1d769a2 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -326,7 +326,7 @@ static int pmc_probe(struct platform_device *ofdev)
 	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
-	struct pmc_type *type;
+	const struct pmc_type *type;
 	int ret = 0;
 
 	match = of_match_device(pmc_match, &ofdev->dev);
-- 
1.7.10.4
