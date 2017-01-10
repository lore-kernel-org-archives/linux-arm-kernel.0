From: david@lechnology.com (David Lechner)
Date: Tue, 10 Jan 2017 10:00:51 -0600
Subject: [PATCH] ARM: davinci_all_defconfig: enable iio
Message-ID: <1484064051-29257-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the iio subsystem. This will be used by LEGO MINDSTORMS EV3,
which has a TI ADS7957 A/DC chip.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 2b1967a..0faf238 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -200,6 +200,12 @@ CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
+CONFIG_IIO=m
+CONFIG_IIO_BUFFER_CB=m
+CONFIG_IIO_SW_DEVICE=m
+CONFIG_IIO_SW_TRIGGER=m
+CONFIG_IIO_HRTIMER_TRIGGER=m
+CONFIG_IIO_SYSFS_TRIGGER=m
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
-- 
2.7.4
