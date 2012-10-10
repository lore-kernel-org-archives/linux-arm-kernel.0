From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 10 Oct 2012 19:30:50 +0100
Subject: [PATCH 3.6.0- 4/6] ARM/pxa: use module_platform_driver macro
Message-ID: <1349893850-7480-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-pxa/tosa-bt.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index b9b1e5c..fe2a9e1 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,17 +132,4 @@ static struct platform_driver tosa_bt_driver = {
 		.owner = THIS_MODULE,
 	},
 };
-
-
-static int __init tosa_bt_init(void)
-{
-	return platform_driver_register(&tosa_bt_driver);
-}
-
-static void __exit tosa_bt_exit(void)
-{
-	platform_driver_unregister(&tosa_bt_driver);
-}
-
-module_init(tosa_bt_init);
-module_exit(tosa_bt_exit);
+module_platform_driver(tosa_bt_driver);
-- 
1.7.0.4
