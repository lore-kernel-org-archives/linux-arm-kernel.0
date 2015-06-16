From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 11:37:16 -0700
Subject: [PATCH] spmi: Select IRQ_DOMAIN instead of depend on it
Message-ID: <1434479836-20947-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ_DOMAIN is a hidden config option, so depending on it doesn't
make any sense. Select the config option because it's required to
compile this driver.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/spmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 982580af1d16..0d3b70b3bda8 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -12,7 +12,7 @@ if SPMI
 
 config SPMI_MSM_PMIC_ARB
 	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
-	depends on IRQ_DOMAIN
+	select IRQ_DOMAIN
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
 	default ARCH_QCOM
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
