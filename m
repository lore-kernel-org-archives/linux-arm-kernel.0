From: agross@codeaurora.org (Andy Gross)
Date: Thu, 26 Nov 2015 00:15:57 -0600
Subject: [PATCH] ARM: multi_v7_defconfig: Enable required QCOM SPMI/PMIC
 drivers
Message-ID: <1448518557-14250-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the QCOM SPMI and PMIC related drivers that are now
required to boot some supported devices.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..8a5227e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -340,10 +340,13 @@ CONFIG_SPI_TEGRA20_SFLASH=y
 CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_SPI_XILINX=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_SPMI=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
+CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_DAVINCI=y
@@ -407,6 +410,7 @@ CONFIG_MFD_MAX8907=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_PM8921_CORE=y
 CONFIG_MFD_QCOM_RPM=y
+CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
-- 
1.9.1
