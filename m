From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Jun 2015 14:45:51 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable usb3503
In-Reply-To: <7hd21b2wo4.fsf@deeprootsystems.com>
References: <1426254866-24772-1-git-send-email-riku.voipio@linaro.org>
 <556FF260.5060006@collabora.co.uk> <7hd21b2wo4.fsf@deeprootsystems.com>
Message-ID: <4414616.t6CSY5FxHU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 June 2015 10:47:07 Kevin Hilman wrote:
> 
> > But I wonder why is not working, shouldn't the driver defer and
> > be probed again once the PHY driver probe succeeds?
> 
> Yeah, I'm not sure why that isn't working, and didn't look into it.
> 
> FWIW, the same problem happens when both are modules.  If you modprobe
> usb3503 first, then the phy, it doesn't work.  You have to load the phy
> before the usb3503.
> 
> 

The driver does not try to get a reference to the phy, and it does
not return -EPROBE_DEFER in any circumstance, so I assume it just
runs into an error condition on the first probe and does not
try again.

I don't really understand why the driver registers both an i2c_driver
and a platform_driver, or if that is required, but it may also
complicate getting deferred probing to work here.

	Arnd
