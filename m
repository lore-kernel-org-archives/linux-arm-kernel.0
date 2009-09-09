From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed,  9 Sep 2009 23:22:47 +0200
Subject: Removing deprecated drivers from drivers/i2c/chips
Message-ID: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

continuing the quest to clean up and ultimately remove the drivers/i2c/chips
directory, this patch series removes three drivers for GPIO-expanders which are
obsoleted and marked as deprecated for more than a year. The newer (and better)
drivers can be found in drivers/gpio.

As it is ensured that the newer drivers cover the same i2c_device_ids, all
platform_devices will still match. Some defconfig updates may be necessary
though, but according to [1] this is left to the arch|platform-maintainers
(also as most defconfigs are quite outdated). For that reason, I put the
relevant arch-mailing-lists to Cc. Comments are welcome.

Regards,

   Wolfram

[1] http://lkml.org/lkml/2009/5/7/34
