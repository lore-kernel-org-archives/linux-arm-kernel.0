From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Feb 2015 16:14:52 -0600
Subject: [PATCH 1/2] arm64: qcom: Add support for Qualcomm MSM8916 SoC
Message-ID: <1425075293-14612-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhimanyu Kapur <abhimany@codeaurora.org>

Add support for Qualcomm MSM8916 SoC in arm64 Kconfig and defconfig.
Enable MSM serial driver utilized by MSM8916 and Qualcomm SoCs in
general.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
---
 arch/arm64/Kconfig           | 18 ++++++++++++++++++
 arch/arm64/configs/defconfig |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..f7af379 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -177,6 +177,24 @@ config ARCH_MEDIATEK
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
+config ARCH_QCOM
+	bool "Qualcomm Platforms"
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLK_QCOM
+	select PINCTRL
+	select SOC_BUS
+	help
+	  This enables support for the ARMv8 based Qualcomm chipsets.
+
+config ARCH_QCOM_MSM8916
+	bool "Enable Support for Qualcomm MSM8916"
+	depends on ARCH_QCOM
+	select MSM_GCC_8916
+	select PINCTRL_MSM8916
+	help
+	  This enables support for the MSM8916 chipset. If you dont
+	  know what do here, say N
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a..c8a0c7c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,6 +33,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_QCOM=y
+CONFIG_ARCH_QCOM_MSM8916=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
@@ -93,6 +95,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_MSM=y
+CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
