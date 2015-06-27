From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Jun 2015 21:02:36 -0600
Subject: [PATCH RFC v2 16/16] drivers: qcom: Enable genpd on selecting QCOM_PM
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1435374156-19214-17-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PM_CPU_DOMAIN and its PM_GENERIC_DOMAINS dependenciesd to provide
cpu domain support for QCOM SoCs.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 01aa2fd..9564a35 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -15,6 +15,9 @@ config QCOM_PM
 	depends on ARCH_QCOM && !ARM64
 	select QCOM_SCM
 	select ARM_CPU_SUSPEND
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_SLEEP
+	select PM_GENERIC_DOMAINS_OF
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in
-- 
2.1.4
