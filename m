From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon,  8 Feb 2016 18:57:39 +0100
Subject: [PATCH 2/2] pinctrl: stm32: Fix compile testing selection
In-Reply-To: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1454954259-4923-3-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While selecting the driver for compile testing seemed possible,
the driver was not compiled because the driver directory was only
added if ARCH_STM32 was selected.

This patch now makes the pinctrl Makefile to add stm32 directory if
PINCTRL_STM32 is selected.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 8adc235..7ea62ef 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -46,7 +46,7 @@ obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
-obj-$(CONFIG_ARCH_STM32)	+= stm32/
+obj-$(CONFIG_PINCTRL_STM32)	+= stm32/
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-- 
1.9.1
