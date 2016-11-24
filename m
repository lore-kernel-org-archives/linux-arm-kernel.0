From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Nov 2016 15:57:52 +0100
Subject: [PATCH] ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms
Message-ID: <1479999472-2664-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysfs ABI to GPIO is marked obsolete and should not be
encouraged. Users should be encouraged to switch to using the
character device.

Let's begin by removing it from the multi defconfigs. Then
as time goes by I can aggressively remove it from other
defconfigs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this for whatever branch holds
defconfig changes.
---
 arch/arm/configs/multi_v5_defconfig | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm64/configs/defconfig        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 2658b80fa263..361686a362f1 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -150,7 +150,6 @@ CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_ORION=y
-CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_QNAP=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 11f37ed1dbff..ed0053da56c6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -404,7 +404,6 @@ CONFIG_PINCTRL_MSM8X74=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
-CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0c1f1c..cea5a9d73506 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -252,7 +252,6 @@ CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
-- 
2.7.4
