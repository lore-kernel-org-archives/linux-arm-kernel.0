From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 17:43:35 +0200
Subject: [PATCH] MMC: meson: remove unused variable
Message-ID: <20160915154349.3005248-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added meson mmc driver causes a build warning from an unused
variable:

drivers/mmc/host/meson-gxbb.c: In function 'meson_mmc_request_done':
drivers/mmc/host/meson-gxbb.c:411:22: error: unused variable 'cmd' [-Werror=unused-variable]

This removes the variable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4b331229dda9 ("MMC: meson: initial support for GXBB platforms")
---
 drivers/mmc/host/meson-gxbb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
index c73c62178764..193d343d0afe 100644
--- a/drivers/mmc/host/meson-gxbb.c
+++ b/drivers/mmc/host/meson-gxbb.c
@@ -408,7 +408,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	struct mmc_command *cmd = host->cmd;
 
 	WARN_ON(host->mrq != mrq);
 
-- 
2.9.0
