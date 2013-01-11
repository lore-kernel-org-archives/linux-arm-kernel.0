From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:24 +0530
Subject: [PATCH v2 05/10] staging: nvec: remove use of clk_get_sys
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-5-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As clock information is added to device tree clock can be looked up
using clk_get. Remove use of clk_get_sys.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/staging/nvec/nvec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index d51615b..9417941 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -770,7 +770,7 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	i2c_clk = clk_get_sys("tegra-i2c.2", "div-clk");
+	i2c_clk = clk_get(&pdev->dev, "div-clk");
 	if (IS_ERR(i2c_clk)) {
 		dev_err(nvec->dev, "failed to get controller clock\n");
 		return -ENODEV;
-- 
1.7.4.1
