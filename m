From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Apr 2014 17:40:15 +0100
Subject: [PATCH 1/4] clk: vexpress: NULL dereference on error path
In-Reply-To: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
References: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1398357618-11050-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Carpenter <dan.carpenter@oracle.com>

If the allocation fails then we dereference the NULL in the error path.
Just return directly.

Fixes: ed27ff1db869 ('clk: Versatile Express clock generators ("osc") driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/clk/versatile/clk-vexpress-osc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 2dc8b41..a535c7b 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -102,7 +102,7 @@ void __init vexpress_osc_of_setup(struct device_node *node)
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
 	if (!osc)
-		goto error;
+		return;
 
 	osc->func = vexpress_config_func_get_by_node(node);
 	if (!osc->func) {
-- 
1.8.3.2
