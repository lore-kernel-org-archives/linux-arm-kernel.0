From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 16:11:04 -0700
Subject: [PATCH] phy: qcom-ufs: Switch dependency to ARCH_QCOM
Message-ID: <1428707466-24526-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This phy only exists on platforms under ARCH_QCOM, not ARCH_MSM.

Cc: Yaniv Gardi <ygardi@codeaurora.org>
Cc: Dov Levenglick <dovl@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de205ba7..9b1ff313bd51 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -286,7 +286,7 @@ config PHY_STIH41X_USB
 
 config PHY_QCOM_UFS
 	tristate "Qualcomm UFS PHY driver"
-	depends on OF && ARCH_MSM
+	depends on OF && ARCH_QCOM
 	select GENERIC_PHY
 	help
 	  Support for UFS PHY on QCOM chipsets.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
