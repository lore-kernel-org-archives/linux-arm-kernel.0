From: colin.king@canonical.com (Colin King)
Date: Wed, 21 Mar 2018 18:01:58 +0000
Subject: [PATCH][next] firmware: arm_scmi: remove redundant null check on array
Message-ID: <20180321180158.2507-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The null check on clk->name is redundant since name is a char array
and can never be null, so the check is always true.  Remove it.

Detected by CoverityScan, CID#1466117 ("Array compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e8ffad33a0ff..0aabffc88599 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -283,7 +283,7 @@ scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 	struct clock_info *ci = handle->clk_priv;
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
-	if (!clk->name || !clk->name[0])
+	if (!clk->name[0])
 		return NULL;
 
 	return clk;
-- 
2.15.1
