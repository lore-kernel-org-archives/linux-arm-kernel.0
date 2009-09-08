From: thomas.ab@samsung.com (thomas.ab at samsung.com)
Date: Tue,  8 Sep 2009 15:46:48 +0900
Subject: [PATCH 1/8] s3c6410: sdhci: Adding additional elements in sdhci
	platform data structure.
Message-ID: <1252392408-23849-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds additional elements in the s3c6410 sdhci
platform data structure. The elements added are parent clock name,
source clock name and desired clock speed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/include/plat/sdhci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-s3c/include/plat/sdhci.h
index f615308..b96ec42 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -37,6 +37,9 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	char		clk_parent_name[20];
+	char            clk_source_name[20];
+	unsigned long   clk_speed;
 
 	char		**clocks;	/* set of clock sources */
 
-- 
1.5.3.4
