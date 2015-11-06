From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 06 Nov 2015 10:57:34 +0530
Subject: [PATCH v2] arm64: defconfig: Enable samsung MFD and related configs
Message-ID: <1446787654-18306-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 based espresso board uses S2MPS15, a multifunction device.
This patch enables S2MPS1X regulator, pmic-clk and rtc drivers utilized by
the same.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
Changes since v1:
* updated the comment message to describe which platfrom uses it.
* enable COMMON_CLK_S2MPS11 which is needed to enable pmic-clk block.

 arch/arm64/configs/defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9492fe7edbbc..2e1f815daa2b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -131,9 +131,11 @@ CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
+CONFIG_REGULATOR_S2MPS11=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -162,6 +164,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
@@ -169,6 +172,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
1.7.10.4
