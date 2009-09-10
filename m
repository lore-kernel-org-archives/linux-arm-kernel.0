From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 10 Sep 2009 12:49:37 +0200
Subject: Removing deprecated drivers from drivers/i2c/chips
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20090910124937.7b3df062@hyperion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed,  9 Sep 2009 23:22:47 +0200, Wolfram Sang wrote:
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

Looks very good, I'll apply the 3 patches removing the legacy drivers.

Not sure about the patch to drivers/gpio/pcf857x.c, as there is no gpio
tree and no maintainer either AFAIK, I guess I shall pick it too?

Thanks,
-- 
Jean Delvare
