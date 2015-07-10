From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 10 Jul 2015 14:18:00 -0600
Subject: [PATCH] drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM
In-Reply-To: <55A01D84.8070701@ti.com>
References: <55A01D84.8070701@ti.com>
Message-ID: <1436559480-9239-1-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable QCOM_SCM for QCOM power management driver

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5eea374..e9a2c19 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -13,6 +13,7 @@ config QCOM_GSBI
 config QCOM_PM
 	bool "Qualcomm Power Management"
 	depends on ARCH_QCOM && !ARM64
+	select QCOM_SCM
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in
-- 
2.1.4
