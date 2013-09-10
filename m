From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:39 +0100
Subject: [PATCH 38/38] iio: magn-core: st: Provide support for the LSM303DLH
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial patch adding the LSM303DLH to the list of already supported
Magnetometer Sensors.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/st_magn.h      | 1 +
 drivers/iio/magnetometer/st_magn_core.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index f185720..19b53e3 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -15,6 +15,7 @@
 #include <linux/iio/common/st_sensors.h>
 
 #define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
+#define LSM303DLH_MAGN_DEV_NAME		"lsm303dlh_magn"
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl_magn"
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 12e7e79..b2e2917 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -151,7 +151,8 @@ static const struct st_sensors st_magn_sensors[] = {
 		.wai = ST_MAGN_1_WAI_EXP,
 		.sensors_supported = {
 			[0] = LSM303DLHC_MAGN_DEV_NAME,
-			[1] = LSM303DLM_MAGN_DEV_NAME,
+			[1] = LSM303DLH_MAGN_DEV_NAME,
+			[0] = LSM303DLM_MAGN_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
 		.odr = {
-- 
1.8.1.2
