From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 10:04:01 -0700
Subject: [PATCH 1/9] crypto: omap-sham - Remove unnecessary pr_info noise
In-Reply-To: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
References: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1356109449-11624-2-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the unnecessary pr_info() call in omap_sham_mod_init().

CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 1d75e6f..2df7a54 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1286,8 +1286,6 @@ static struct platform_driver omap_sham_driver = {
 
 static int __init omap_sham_mod_init(void)
 {
-	pr_info("loading %s driver\n", "omap-sham");
-
 	return platform_driver_register(&omap_sham_driver);
 }
 
-- 
1.7.12
