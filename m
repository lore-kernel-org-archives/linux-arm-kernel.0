From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 24 Sep 2015 13:39:15 +0200
Subject: [PATCH v2 1/5] ARM: multi_v7_defconfig: Enable common Rockchip
 devices/busses
In-Reply-To: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1443094759-28531-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Rockchip I2C, SPI, PWM, thermal drivers.

Builtin are I2C (as it often required to control the pmic) and Thermal
drivers (to prevent thermal damage). SPI and PWM drivers configured as
modules

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..170f18e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -302,6 +302,7 @@ CONFIG_I2C_GPIO=m
 CONFIG_I2C_EXYNOS5=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_RIIC=y
+CONFIG_I2C_RK3X=y
 CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_SIRF=y
@@ -318,6 +319,7 @@ CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
+CONFIG_SPI_ROCKCHIP=m
 CONFIG_SPI_RSPI=y
 CONFIG_SPI_S3C64XX=m
 CONFIG_SPI_SH_MSIOF=m
@@ -365,6 +367,7 @@ CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
+CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG=m
@@ -643,6 +646,7 @@ CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_RENESAS_TPU=y
+CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
-- 
2.5.3
