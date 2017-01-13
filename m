From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 14:00:12 -0600
Subject: [PATCH v2 2/2] ARM: davinci_all_defconfig: enable iio
In-Reply-To: <1484337612-11120-1-git-send-email-david@lechnology.com>
References: <1484337612-11120-1-git-send-email-david@lechnology.com>
Message-ID: <1484337612-11120-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the iio subsystem. This will be used by LEGO MINDSTORMS EV3,
which has an ADS7957 chip.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index f598daa..8cc0409 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -201,6 +201,15 @@ CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
+CONFIG_IIO=m
+CONFIG_IIO_BUFFER=y
+CONFIG_IIO_BUFFER_CB=m
+CONFIG_IIO_KFIFO_BUF=m
+CONFIG_IIO_TRIGGER=y
+CONFIG_IIO_SW_DEVICE=m
+CONFIG_IIO_SW_TRIGGER=m
+CONFIG_IIO_HRTIMER_TRIGGER=m
+CONFIG_IIO_SYSFS_TRIGGER=m
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
-- 
2.7.4
