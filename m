From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 12 Oct 2012 08:11:08 +0100
Subject: [RESEND] [PATCH 3.6.0- 1/6] ARM/omap1: use module_platform_driver
 macro
Message-ID: <1350025868-30482-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-omap1/mailbox.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e962926..45c8719 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -179,19 +179,7 @@ static struct platform_driver omap1_mbox_driver = {
 		.name	= "omap-mailbox",
 	},
 };
-
-static int __init omap1_mbox_init(void)
-{
-	return platform_driver_register(&omap1_mbox_driver);
-}
-
-static void __exit omap1_mbox_exit(void)
-{
-	platform_driver_unregister(&omap1_mbox_driver);
-}
-
-module_init(omap1_mbox_init);
-module_exit(omap1_mbox_exit);
+module_platform_driver(omap1_mbox_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
-- 
1.7.0.4
