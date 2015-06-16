From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 13:31:16 -0700
Subject: [PATCH 5/5] ARM: qcom_defconfig: Enable options for KS8851 ethernet
In-Reply-To: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434486676-21812-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RPM and RPM regulator drivers as well as the KS8851
ethernet driver so that ethernet works on MSM8960 CDP.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index e6a6f282e3de..ff7985ba226e 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -67,6 +67,7 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_KS8851=y
 CONFIG_MDIO_BITBANG=y
 CONFIG_MDIO_GPIO=y
 CONFIG_SLIP=y
@@ -104,8 +105,10 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
+CONFIG_MFD_QCOM_RPM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_SOUND=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
