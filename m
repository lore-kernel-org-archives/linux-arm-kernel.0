From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 1 Dec 2015 14:47:50 -0800
Subject: [PATCH] ARM: defconfig: multi_v7: Enable Qualcomm options for Honami
In-Reply-To: <1448518557-14250-1-git-send-email-agross@codeaurora.org>
Message-ID: <1449010070-9796-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Honami device does not boot due to the lack of pinctrl support
compiled in with the multi_v7_defconfig. This patch correct this and
enables coincell, sdhci, smsm, smp2p and wcnss_ctrl as well, all found
on a variety of Qualcomm boards.

Reported-by: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

For next/deconfig.

As Kevin reported the Honami stops booting with the addition of pinctrl
reference in the serial node, simply due to the fact that it references a
pinctrl driver that's not enabled in the defconfig.

The patch sent by Andy is hence not enough to fix the problem.


PS. It would be mighty convenient if savedefconfig could be used on the
multi_v7_defconfig.

 arch/arm/configs/multi_v7_defconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fa7ba92cfe70..dc30a48374b2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -186,6 +186,7 @@ CONFIG_AD525X_DPOT_I2C=y
 CONFIG_ATMEL_TCLIB=y
 CONFIG_ICS932S401=y
 CONFIG_ATMEL_SSC=m
+CONFIG_QCOM_COINCELL=m
 CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
 CONFIG_EEPROM_AT24=y
@@ -347,6 +348,11 @@ CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
+CONFIG_PINCTRL_IPQ8064=y
+CONFIG_PINCTRL_MSM8660=y
+CONFIG_PINCTRL_MSM8960=y
+CONFIG_PINCTRL_MSM8X74=y
+CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIO_SYSFS=y
@@ -580,6 +586,7 @@ CONFIG_MMC_SDHCI_ST=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MMC_ATMELMCI=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
@@ -668,9 +675,12 @@ CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
-CONFIG_QCOM_SMEM=y
+CONFIG_QCOM_SMP2P=y
+CONFIG_QCOM_SMSM=y
+CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
-- 
2.4.2
