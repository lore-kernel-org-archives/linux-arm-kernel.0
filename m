From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Aug 2015 10:32:42 -0600
Subject: [PATCH RFC 06/10] drivers: qcom: Enable genpd on selecting QCOM_PM
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1438792366-2737-7-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PM_CPU_DOMAIN and its PM_GENERIC_DOMAINS dependenciesd to provide
cpu domain support for QCOM SoCs.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba47b70..b6c2e5d 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -14,6 +14,10 @@ config QCOM_PM
 	bool "Qualcomm Power Management"
 	depends on ARCH_QCOM && !ARM64
 	select QCOM_SCM
+	select ARM_CPU_SUSPEND
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_SLEEP
+	select PM_GENERIC_DOMAINS_OF
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in
-- 
2.1.4
