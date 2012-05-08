From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 10:19:02 -0700
Subject: [PATCH 2/2] mfd: twl: remove pdata->irq_base/_end, no more users
In-Reply-To: <1336497542-13629-1-git-send-email-khilman@ti.com>
References: <1336497542-13629-1-git-send-email-khilman@ti.com>
Message-ID: <1336497542-13629-3-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After converstion to SPARSE_IRQ, the driver doesn't use the
pdata->irq_base/irq_end fields anymore.  The last users
have been cleanup up, and now these fields can be removed.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 include/linux/i2c/twl.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 1f90de0..f8b967c 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -685,7 +685,6 @@ struct twl4030_audio_data {
 };
 
 struct twl4030_platform_data {
-	unsigned				irq_base, irq_end;
 	struct twl4030_clock_init_data		*clock;
 	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
-- 
1.7.9.2
