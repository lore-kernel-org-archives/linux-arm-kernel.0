From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Sep 2014 15:06:27 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Maxim 77693 and I2C GPIO
 drivers
Message-ID: <1410527187-26588-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos System-on-Chips have ~7 distinctive I2C IO ports (exact
number depends on chip). However some integrated circuits on board, also
using I2C protocol for communication, can be connected to the SoC by
other GPIO. Enabling the I2C GPIO driver allows using such additional
integrated circuits.

An example of such chip using I2C and connected over GPIO to SoC is
Maxim 77693 MUIC on Trats2 board. The regulator driver of Maxim 77693
offers charger and safeout LDO (necessary for USB OTG).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb758d9..5eb5c9e9510c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -200,6 +200,7 @@ CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_CADENCE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_EXYNOS5=y
+CONFIG_I2C_GPIO=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
@@ -244,6 +245,7 @@ CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_MAX8907=y
+CONFIG_MFD_MAX77693=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -256,6 +258,7 @@ CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MAX8907=y
+CONFIG_REGULATOR_MAX77693=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
-- 
1.9.1
