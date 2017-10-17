From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Oct 2017 11:32:08 +0200
Subject: [PATCH] ARM: defconfig: select the right SX150X driver
Message-ID: <20171017093208.5313-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SX150X GPIO expander has been moved to pin control and
its Kconfig symbol has been renamed. We used to have a paper-over
thing in Kconfig but it was causing circular dependencies so
I have had to kill it off. Select the right driver instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for ARM SoC.
---
 arch/arm/configs/lpc32xx_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index e15fa5f168bb..0b54b4024e51 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -108,11 +108,11 @@ CONFIG_GPIO_MAX7300=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
-CONFIG_GPIO_SX150X=y
 CONFIG_GPIO_74X164=y
 CONFIG_GPIO_MAX7301=y
 CONFIG_GPIO_MC33880=y
 CONFIG_PINCTRL_MCP23S08=y
+CONFIG_PINCTRL_SX150X=y
 CONFIG_SENSORS_DS620=y
 CONFIG_SENSORS_MAX6639=y
 CONFIG_WATCHDOG=y
-- 
2.13.5
