From: david@lechnology.com (David Lechner)
Date: Fri, 21 Oct 2016 13:36:55 -0500
Subject: [PATCH 3/5] ARM: davinci: enable gpio poweroff in default config
In-Reply-To: <1477075018-20176-1-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
Message-ID: <1477075018-20176-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-poweroff driver is needed by LEGO MINDSTORMS EV3 (AM1808 based
board).

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9254609..9d7f0bc 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -117,6 +117,8 @@ CONFIG_SPI_DAVINCI=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 CONFIG_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_MFD_DM355EVM_MSP=y
-- 
2.7.4
