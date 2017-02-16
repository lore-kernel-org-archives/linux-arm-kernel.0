From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 18:58:40 +0100
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable IRQ support for pca953x
In-Reply-To: <1487267920-3952-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487267920-3952-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487267920-3952-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need IRQs from the tca6416 expander for vpif capture to work on the
da850-evm board.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index bf2c0ca..91557ae 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -121,6 +121,7 @@ CONFIG_PINCTRL_DA850_PUPD=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_WATCHDOG=y
-- 
2.9.3
