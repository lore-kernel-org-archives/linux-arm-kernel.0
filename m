From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 23 Sep 2013 16:36:38 +0200
Subject: [PATCH 9/9] Staging/iio: add TODO reminder
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1379946998-23041-10-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some things have still to be done to the LRADC driver.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel at lists.infradead.org
CC: linux-input at vger.kernel.org
CC: devel at driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/TODO | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 04c2326..c22a0ed 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -13,6 +13,17 @@ Would be nice
 3) Expand device set. Lots of other maxim adc's have very
    similar interfaces.
 
+MXS LRADC driver:
+This is a classic MFD device as it combines the following subdevices
+ - touchscreen controller (input subsystem related device)
+ - general purpose ADC channels
+ - battery voltage monitor (power subsystem related device)
+ - die temperature monitor (thermal management)
+
+At least the battery voltage and die temperature feature is required in-kernel
+by a driver of the SoC's battery charging unit to avoid any damage to the
+silicon and the battery.
+
 TSL2561
 Would be nice
 1) Open question of userspace vs kernel space balance when
-- 
1.8.4.rc3
