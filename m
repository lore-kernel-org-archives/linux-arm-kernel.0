From: vviswana@codeaurora.org (Vijay Viswanath)
Date: Wed, 30 Aug 2017 18:21:49 +0530
Subject: [PATCH v1 5/5] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
In-Reply-To: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
References: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
Message-ID: <1504097509-58983-6-git-send-email-vviswana@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
register read and write APIs, if registered, can be used.
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db84dd..64a9298 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -420,6 +420,7 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select CONFIG_MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
