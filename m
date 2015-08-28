From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Aug 2015 11:23:33 -0700
Subject: [PATCH] soc: qcom: Reorder SMEM/SMD configs
Message-ID: <1440786213-23375-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I make nconfig, having the SMEM option after the SMD option
causes the configurator to get confused when I'm enabling and
disabling these options. Let's move SMEM before SMD so there's a
clear indented dependency chain.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/soc/qcom/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba47b70f4d85..3e4d2133c3d2 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -19,6 +19,14 @@ config QCOM_PM
 	  modes. It interface with various system drivers to put the cores in
 	  low power modes.
 
+config QCOM_SMEM
+	tristate "Qualcomm Shared Memory Manager (SMEM)"
+	depends on ARCH_QCOM
+	help
+	  Say y here to enable support for the Qualcomm Shared Memory Manager.
+	  The driver provides an interface to items in a heap shared among all
+	  processors in a Qualcomm platform.
+
 config QCOM_SMD
 	tristate "Qualcomm Shared Memory Driver (SMD)"
 	depends on QCOM_SMEM
@@ -40,11 +48,3 @@ config QCOM_SMD_RPM
 
 	  Say M here if you want to include support for the Qualcomm RPM as a
 	  module. This will build a module called "qcom-smd-rpm".
-
-config QCOM_SMEM
-	tristate "Qualcomm Shared Memory Manager (SMEM)"
-	depends on ARCH_QCOM
-	help
-	  Say y here to enable support for the Qualcomm Shared Memory Manager.
-	  The driver provides an interface to items in a heap shared among all
-	  processors in a Qualcomm platform.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
