From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 22:21:14 +0100
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: enable Rockchip io-domain driver
Message-ID: <2111669.2aeXLpXsWE@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The io-domain driver is necessary to notify the soc about voltages changes
happening on supplying regulators. Probably the most important user right
now is the mmc tuning code, where the soc needs to get notified when the
voltage is dropped to the 1.8V point.

As this option is necessary to sucessfully tune UHS cards etc, it should
get built in.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
When booting a Veyron-Jerry from an sd-card it got stuck, as the tuning
failed due to the missing voltage notification and the mmc completely
fails initialization of the card, if this happens.
With this option enabled, I could again boot from my sd-card.

This is based on the 

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..be57898 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -371,6 +371,8 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_AVS=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
-- 
2.6.4
