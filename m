From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:20 +0200
Subject: [PATCH 15/25] powerpc/fsl_msi: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	arch/powerpc/sysdev/fsl_msi.c: In function 'fsl_of_msi_probe':
	arch/powerpc/sysdev/fsl_msi.c:379:11: error: assignment discards 'const' qualifier from pointer target type [-Werror]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 6e097de..a40acd6 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -368,7 +368,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 	int err, i, j, irq_index, count;
 	int rc;
 	const u32 *p;
-	struct fsl_msi_feature *features;
+	const struct fsl_msi_feature *features;
 	int len;
 	u32 offset;
 	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
-- 
1.7.10.4
