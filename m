From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 10 Jun 2014 12:16:20 +0100
Subject: [PATCH] ARM: qcom: select GSBI from mach kconfig
Message-ID: <1402398980-24664-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GSBI selection automatically from mach kconfig, As GSBI
seems to be the very basic SOC specific driver and serial driver depends on it.
I think this option should be selected via mach kconfig rather than adding
it to any defconfig.

Without this patch multi_v7_defconfig can not show up console on
IFC6410.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/mach-qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 5bac591..d68d7ee 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -7,6 +7,7 @@ config ARCH_QCOM
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SMP
 	select QCOM_SCM if SMP
+	select QCOM_GSBI
 	help
 	  Support for Qualcomm's devicetree based systems.
 
-- 
1.9.1
