From: bshah@kde.org (Bhushan Shah)
Date: Thu, 15 Jun 2017 11:45:21 +0530
Subject: [PATCH] ARM: qcom_defconfig: enable RPMSG_QCOM_SMD
Message-ID: <20170615061521.21292-1-bshah@kde.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 5052de8deff56, QCOM_SMD_RPM and various other config
options enabled in the qcom_defconfig depends on the RPMSG. If
QCOM_SMD_RPM config option is not selected it disables the
REGULATOR_QCOM_SMD_RPM and other essential config options.

Signed-off-by: Bhushan Shah <bshah@kde.org>
---
I believe this patch should be included in the current rc version as well
otherwise boards that depend on pm8941 are not functional (for example   
msm8974-hamerhead had emmc not working).                                 

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 07666a7a9de5..65356a3a9253 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -173,6 +173,7 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PM8058=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PM8XXX=y
 CONFIG_DMADEVICES=y
-- 
2.13.0
