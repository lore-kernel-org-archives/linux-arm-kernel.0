From: davem@davemloft.net (David Miller)
Date: Thu, 18 Feb 2016 16:00:09 -0500 (EST)
Subject: [PATCH] USB: cdc_subset: only build when one driver is enabled
In-Reply-To: <1455747932-2844084-1-git-send-email-arnd@arndb.de>
References: <1455747932-2844084-1-git-send-email-arnd@arndb.de>
Message-ID: <20160218.160009.1485326686227753180.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Feb 2016 23:25:11 +0100

> This avoids a harmless randconfig warning I get when USB_NET_CDC_SUBSET
> is enabled, but all of the more specific drivers are not:
> 
> drivers/net/usb/cdc_subset.c:241:2: #warning You need to configure some hardware for this driver
> 
> The current behavior is clearly intentional, giving a warning when
> a user picks a configuration that won't do anything good. The only
> reason for even addressing this is that I'm getting close to
> eliminating all 'randconfig' warnings on ARM, and this came up
> a couple of times.
> 
> My workaround is to not even build the module when none of the
> configurations are enable.
> 
> Alternatively we could simply remove the #warning (nothing wrong
> for compile-testing), turn it into a runtime warning, or
> change the Kconfig options into a menu to hide CONFIG_USB_NET_CDC_SUBSET.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
