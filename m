From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:28 +0100
Subject: [PATCH 27/38] iio: pressure-core: st: Give some indication if device
 probing was successful
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment the driver is silent in some error cases and if successful.
Prior to this patch there was no clear way to know if the driver succeeded
or not without looking deep into sysfs.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/pressure/st_pressure_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 6ffd949..34b3fb1 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -280,6 +280,9 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	if (err && irq > 0)
 		goto st_press_device_register_error;
 
+	if (!err)
+		dev_info(&indio_dev->dev, "Successfully registered\n");
+
 	return err;
 
 st_press_device_register_error:
-- 
1.8.1.2
