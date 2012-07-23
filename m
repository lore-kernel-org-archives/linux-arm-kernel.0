From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:26 +0200
Subject: [PATCH 21/25] powerpc/fsl_msi: drop unneeded cast to non-const pointer
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This cast is unneeded since *of_device_id.data became const.

[ukl: split Arnd's patch by driver and add changelog]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/sysdev/fsl_msi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index a40acd6..51ffafa 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -502,15 +502,15 @@ static const struct fsl_msi_feature vmpic_msi_feature = {
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
 		.compatible = "fsl,mpic-msi",
-		.data = (void *)&mpic_msi_feature,
+		.data = &mpic_msi_feature,
 	},
 	{
 		.compatible = "fsl,ipic-msi",
-		.data = (void *)&ipic_msi_feature,
+		.data = &ipic_msi_feature,
 	},
 	{
 		.compatible = "fsl,vmpic-msi",
-		.data = (void *)&vmpic_msi_feature,
+		.data = &vmpic_msi_feature,
 	},
 	{}
 };
-- 
1.7.10.4
