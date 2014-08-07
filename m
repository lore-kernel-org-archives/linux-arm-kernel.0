From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 8 Aug 2014 02:01:54 +0300
Subject: [PATCH 2/3] soc/tegra: Use of_match_machine in soc_is_tegra()
In-Reply-To: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1407452515-2390-3-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new helper function, also fixing a device_node refcount leak.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 drivers/soc/tegra/common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a71cb74..f6571f5 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -20,11 +20,5 @@ static const struct of_device_id tegra_machine_match[] = {
 
 bool soc_is_tegra(void)
 {
-	struct device_node *root;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return false;
-
-	return of_match_node(tegra_machine_match, root) != NULL;
+	return of_match_machine(tegra_machine_match) != NULL;
 }
-- 
1.8.1.5
