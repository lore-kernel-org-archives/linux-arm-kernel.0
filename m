From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 05 Feb 2016 11:34:29 +0530
Subject: [PATCH v3] arm64: defconfig: Enable samsung MFD and related configs
Message-ID: <1454652269-6100-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 based espresso board uses S2MPS15, a multifunction device.
This patch enables S2MPS1X regulator, pmic-clk and rtc drivers utilized by
the same.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changes since v2:
* Added Reviewed-by from Krzysztof
* rebased on next-20160204

Changes since v1:
* updated the comment message to describe which platfrom uses it.
* enable COMMON_CLK_S2MPS11 which is needed to enable pmic-clk block.

 arch/arm64/configs/defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86581f7..2fd2264 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -151,9 +151,11 @@ CONFIG_GPIO_XGENE=y
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
@@ -188,6 +190,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_XGENE=y
-- 
1.7.10.4
