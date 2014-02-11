From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 11 Feb 2014 14:22:06 -0600
Subject: [PATCH] power: reset: msm - switch Kconfig to ARCH_QCOM depends
Message-ID: <1392150126-21744-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've split Qualcomm MSM support into legacy and multiplatform.  The reset
driver is only relevant on the multiplatform supported SoCs so switch the
Kconfig depends to ARCH_QCOM.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
Dmitry, David,

If you can ack this I'll send it via linux-qcom/arm-soc tree's

thanks

- k

 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6d452a7..fa0e4e0 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -22,7 +22,7 @@ config POWER_RESET_GPIO
 
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
-	depends on POWER_RESET && ARCH_MSM
+	depends on POWER_RESET && ARCH_QCOM
 	help
 	  Power off and restart support for Qualcomm boards.
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
