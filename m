From: adam.yh.lee@gmail.com (Adam YH Lee)
Date: Tue,  4 Aug 2015 11:15:47 -0700
Subject: [V4] [TWL4030 MADC] Correction and clean-up
Message-ID: <1438712148-27004-1-git-send-email-adam.yh.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V4 of this patch addresses issues raised by Jonathan [1].

"iio_device_register" call should be the last call in the probe.
All regulators should be configured before that call.

Remove devm_regulator_put as it is not necessary. "devm_allocators"
(devm_regulator_get, in this case) does device removal as well as error
handling.

[1] http://www.spinics.net/lists/linux-omap/msg120871.html

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.1.4
