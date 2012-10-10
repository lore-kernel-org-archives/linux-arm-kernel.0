From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 10 Oct 2012 19:30:17 +0100
Subject: [PATCH 3.6.0- 2/6] ARM/omap2: use module_platform_driver macro
Message-ID: <1349893817-7406-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-omap2/mailbox.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 0d97456..eb64ca9 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -409,19 +409,7 @@ static struct platform_driver omap2_mbox_driver = {
 		.name = "omap-mailbox",
 	},
 };
-
-static int __init omap2_mbox_init(void)
-{
-	return platform_driver_register(&omap2_mbox_driver);
-}
-
-static void __exit omap2_mbox_exit(void)
-{
-	platform_driver_unregister(&omap2_mbox_driver);
-}
-
-module_init(omap2_mbox_init);
-module_exit(omap2_mbox_exit);
+module_platform_driver(omap2_mbox_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
-- 
1.7.0.4
