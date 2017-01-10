From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Jan 2017 10:55:21 +0100
Subject: [PATCH] ARM: defconfig: qcom: add APQ8060 DragonBoard devices
Message-ID: <20170110095521.14146-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This default-enables the devices found on the APQ8060 DragonBoard
in the qcom_defconfig:

- EBI2 bus
- SMSC911x ethernet
- LEDs class and PM8058 LEDs driver, trigger and heartbeat
  trigger (so we get heartbeat on the board by default)
- IIO framework, including the HRTimer trigger, KXSD9
  accelerometer, MPU3050 gyroscope, AK8975 magnetometer and
  BMP085 pressure sensor

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c3a0108a231..eed314e39721 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -55,6 +55,7 @@ CONFIG_CFG80211=y
 CONFIG_RFKILL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_QCOM_EBI2=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -71,6 +72,7 @@ CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_KS8851=y
+CONFIG_SMSC911X=y
 CONFIG_MDIO_BITBANG=y
 CONFIG_MDIO_GPIO=y
 CONFIG_SLIP=y
@@ -151,6 +153,12 @@ CONFIG_MMC_QCOM_DML=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PM8058=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PM8XXX=y
 CONFIG_DMADEVICES=y
@@ -171,6 +179,14 @@ CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
+CONFIG_IIO=y
+CONFIG_IIO_BUFFER_CB=y
+CONFIG_IIO_SW_TRIGGER=y
+CONFIG_KXSD9=y
+CONFIG_MPU3050_I2C=y
+CONFIG_AK8975=y
+CONFIG_IIO_HRTIMER_TRIGGER=y
+CONFIG_BMP280=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
 CONFIG_EXT2_FS=y
-- 
2.9.3
