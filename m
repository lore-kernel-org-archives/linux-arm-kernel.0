From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 23 Feb 2018 22:42:04 -0300
Subject: [PATCH] ARM: imx: pm-imx6: Return the error directly
Message-ID: <1519436524-24583-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Simplify the error path by returning the error code directly rather
than jumping to a label.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index ecdf071..017539d 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -428,10 +428,8 @@ static int __init imx6_pm_get_base(struct imx6_pm_base *base,
 	int ret = 0;
 
 	node = of_find_compatible_node(NULL, NULL, compat);
-	if (!node) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!node)
+		return -ENODEV;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -444,7 +442,6 @@ static int __init imx6_pm_get_base(struct imx6_pm_base *base,
 
 put_node:
 	of_node_put(node);
-out:
 	return ret;
 }
 
-- 
2.7.4
