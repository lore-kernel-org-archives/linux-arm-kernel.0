From: agross@codeaurora.org (Andy Gross)
Date: Thu,  8 Oct 2015 15:37:08 -0500
Subject: [PATCH] arm64: defconfig: Enable devices for MSM8916
Message-ID: <1444336628-21855-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables a number of devices currently supported by the MSM8916
boards.  These include I2C, SPI, DMA, SMEM, SMD, and SMD regulator support.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm64/configs/defconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..2ae0833 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -116,8 +116,11 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_QUP=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_SPI_QUP=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_XGENE=y
@@ -126,6 +129,7 @@ CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -154,12 +158,18 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_DMADEVICES=y
+CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
+CONFIG_HWSPINLOCK_QCOM=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_QCOM_SMEM=y
+CONFIG_QCOM_SMD=y
+CONFIG_QCOM_SMD_RPM=y
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
