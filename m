From: vapier.adi@gmail.com (Mike Frysinger)
Date: Wed, 9 Sep 2009 19:54:34 -0400
Subject: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2009 at 17:22, Wolfram Sang wrote:
> continuing the quest to clean up and ultimately remove the drivers/i2c/chips
> directory, this patch series removes three drivers for GPIO-expanders which are
> obsoleted and marked as deprecated for more than a year. The newer (and better)
> drivers can be found in drivers/gpio.
>
> As it is ensured that the newer drivers cover the same i2c_device_ids, all
> platform_devices will still match. Some defconfig updates may be necessary
> though, but according to [1] this is left to the arch|platform-maintainers
> (also as most defconfigs are quite outdated). For that reason, I put the
> relevant arch-mailing-lists to Cc. Comments are welcome.

the Blackfin defconfigs refer to an input driver for the PCF8574, not
the I2C client driver
-mike
