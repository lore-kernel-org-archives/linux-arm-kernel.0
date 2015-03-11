From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 11 Mar 2015 15:51:17 -0500
Subject: [PATCH v3 1/4] arm64: qcom: Add support for Qualcomm MSM8916 SoC
Message-ID: <1426107080-29079-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhimanyu Kapur <abhimany@codeaurora.org>

Add support for Qualcomm MSM8916 SoC in arm64 Kconfig and defconfig.
Enable MSM8916 clock, pin control, and MSM serial driver utilized by
MSM8916 and Qualcomm SoCs in general.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
---
v3:
* Dropped ARCH_REQUIRE_GPIOLIB, COMMON_CLK_QCOM, and SOC_BUS
* Updated defconfig related to dropping various Kconfig options

v2:
* Dropped CONFIG_ARCH_QCOM_MSM8916, just use CONFIG_ARCH_QCOM
* Updated defconfig related to dropping CONFIG_ARCH_QCOM_MSM8916

 arch/arm64/Kconfig           | 6 ++++++
 arch/arm64/configs/defconfig | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..610965dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -177,6 +177,12 @@ config ARCH_MEDIATEK
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
+config ARCH_QCOM
+	bool "Qualcomm Platforms"
+	select PINCTRL
+	help
+	  This enables support for the ARMv8 based Qualcomm chipsets.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a..d54a1f6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_MEDIATEK=y
+CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
@@ -93,11 +94,14 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_MSM=y
+CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_XGENE=y
 # CONFIG_HWMON is not set
@@ -127,6 +131,8 @@ CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_QCOM=y
+CONFIG_MSM_GCC_8916=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
