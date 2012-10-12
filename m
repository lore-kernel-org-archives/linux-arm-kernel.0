From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 12 Oct 2012 08:11:20 +0100
Subject: [RESEND] [PATCH 3.6.0- 3/6] ARM/pxa: use module_platform_driver macro
Message-ID: <1350025880-30551-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-pxa/pxa3xx-ulpi.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index 7dbe3cc..e329cce 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -384,18 +384,7 @@ static struct platform_driver pxa3xx_u2d_ulpi_driver = {
         .probe          = pxa3xx_u2d_probe,
         .remove         = pxa3xx_u2d_remove,
 };
-
-static int pxa3xx_u2d_ulpi_init(void)
-{
-	return platform_driver_register(&pxa3xx_u2d_ulpi_driver);
-}
-module_init(pxa3xx_u2d_ulpi_init);
-
-static void __exit pxa3xx_u2d_ulpi_exit(void)
-{
-	platform_driver_unregister(&pxa3xx_u2d_ulpi_driver);
-}
-module_exit(pxa3xx_u2d_ulpi_exit);
+module_platform_driver(pxa3xx_u2d_ulpi_driver);
 
 MODULE_DESCRIPTION("PXA3xx U2D ULPI driver");
 MODULE_AUTHOR("Igor Grinberg");
-- 
1.7.0.4
