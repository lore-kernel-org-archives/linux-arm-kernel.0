From: vviswana@codeaurora.org (Vijay Viswanath)
Date: Wed, 27 Sep 2017 11:04:42 +0530
Subject: [PATCH v2 3/4] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
In-Reply-To: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
Message-ID: <1506490483-46871-4-git-send-email-vviswana@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
register read and write APIs, if registered, can be used.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db84dd..11bfb82 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -420,6 +420,7 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
