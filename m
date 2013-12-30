From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Dec 2013 13:15:28 -0800
Subject: [PATCH v2 2/7] mmc: msm_sdcc: Limit driver to platforms that use it
In-Reply-To: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1388438133-431-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm_sdcc driver uses mach specific dma APIs. This is not
compatible with the multi-platform ARM effort. Let's only compile
this driver on MSM devices that are prepared to support it,
allowing the DT based MSM devices to enter the multi-platform ARM
build.

Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..4e8ca9d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -324,7 +324,7 @@ config MMC_ATMELMCI
 
 config MMC_MSM
 	tristate "Qualcomm SDCC Controller Support"
-	depends on MMC && ARCH_MSM
+	depends on MMC && (ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50)
 	help
 	  This provides support for the SD/MMC cell found in the
 	  MSM and QSD SOCs from Qualcomm. The controller also has
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
