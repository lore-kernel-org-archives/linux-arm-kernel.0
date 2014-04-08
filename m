From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 8 Apr 2014 10:08:55 -0300
Subject: [PATCH] arm: scoop: Remove unused variable
Message-ID: <1396962535-6249-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the 'temp' variable in order to fix the following build warning:

arch/arm/common/scoop.c:185:6: warning: unused variable 'temp' [-Wunused-variable]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/common/scoop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 6ef146e..a20fa80 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -182,7 +182,6 @@ static int scoop_probe(struct platform_device *pdev)
 	struct scoop_config *inf;
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret;
-	int temp;
 
 	if (!mem)
 		return -EINVAL;
-- 
1.8.3.2
