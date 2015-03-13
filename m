From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:44 -0700
Subject: [PATCH 11/12] ufs-qcom: Switch dependency to ARCH_QCOM
In-Reply-To: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426270185-19510-12-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device only exists on platforms under ARCH_QCOM, not
ARCH_MSM.

Cc: Yaniv Gardi <ygardi@codeaurora.org>
Cc: Dov Levenglick <dovl@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This can be acked and go through arm-soc or applied directly. 

 drivers/scsi/ufs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 8a1f4b355416..e94538362536 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -73,7 +73,7 @@ config SCSI_UFSHCD_PLATFORM
 
 config SCSI_UFS_QCOM
 	bool "QCOM specific hooks to UFS controller platform driver"
-	depends on SCSI_UFSHCD_PLATFORM && ARCH_MSM
+	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
 	select PHY_QCOM_UFS
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
