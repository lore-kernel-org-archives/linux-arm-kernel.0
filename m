From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 10 Oct 2012 19:31:07 +0100
Subject: [PATCH 3.6.0- 6/6] omap_rng: use module_platform_driver macro
Message-ID: <1349893867-7548-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/char/hw_random/omap-rng.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index a5effd8..29732c6 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -217,19 +217,7 @@ static struct platform_driver omap_rng_driver = {
 	.probe		= omap_rng_probe,
 	.remove		= __exit_p(omap_rng_remove),
 };
-
-static int __init omap_rng_init(void)
-{
-	return platform_driver_register(&omap_rng_driver);
-}
-
-static void __exit omap_rng_exit(void)
-{
-	platform_driver_unregister(&omap_rng_driver);
-}
-
-module_init(omap_rng_init);
-module_exit(omap_rng_exit);
+module_platform_driver(omap_rng_driver);
 
 MODULE_AUTHOR("Deepak Saxena (and others)");
 MODULE_LICENSE("GPL");
-- 
1.7.0.4
