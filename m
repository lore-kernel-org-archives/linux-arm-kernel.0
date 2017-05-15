From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon, 15 May 2017 13:00:29 +0300
Subject: [PATCH] arm64: defconfig: Switch to the correct Qualcomm SMD driver
Message-ID: <20170515100029.12501-1-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMD driver is migrated to a new RPMSG-based one and the old
driver was removed with:
commit 395a48053af6 ("soc: qcom: smd: Remove standalone driver")

However in defconfig we still have the old driver leaving the
SMD-regulator driver with unsatisfied dependencies. The result
is that the SMD-regulator driver is not compiled and the apq8016
boards could not probe their onboard storage and mount rootfs.

Fix this by switching to the new SMD driver, so that the required
driver is compiled again.

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ce072859e3b2..08f6f96057d4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -470,9 +470,9 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_HI6220_MBOX=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
+CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
