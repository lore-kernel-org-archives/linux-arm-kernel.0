From: david@lechnology.com (David Lechner)
Date: Mon,  9 Jan 2017 10:11:40 -0600
Subject: [RESEND 3/3] ARM: davinci_all_defconfig: enable iio and ADS7950
In-Reply-To: <1483978300-403-1-git-send-email-david@lechnology.com>
References: <1483978300-403-1-git-send-email-david@lechnology.com>
Message-ID: <1483978300-403-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the iio subsystem and the TI ADS7950 driver. This is used by
LEGO MINDSTORMS EV3, which has an ADS7957 chip.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 2b1967a..a899876 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -200,6 +200,13 @@ CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
+CONFIG_IIO=m
+CONFIG_IIO_BUFFER_CB=m
+CONFIG_IIO_SW_DEVICE=m
+CONFIG_IIO_SW_TRIGGER=m
+CONFIG_TI_ADS7950=m
+CONFIG_IIO_HRTIMER_TRIGGER=m
+CONFIG_IIO_SYSFS_TRIGGER=m
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
-- 
2.7.4
