From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Aug 2015 08:44:19 +0200
Subject: [PATCH V3] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Message-ID: <20150819064419.GC9999@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 19, 2015 at 08:58:24AM +0530, Pratyush Anand wrote:
> /sys/class/watchdog/watchdogn/device/modalias can help to identify the
> driver/module for a given watchdog node. However, many wdt devices does not set

s/es//

> its parent and so, we do not see an entry for device in sysfs for such devices.
> 
> This patch fixes parent of watchdog_device so that
> /sys/class/watchdog/watchdogn/device is populated.
> 
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can we identify driver for these devices.

I don't see why you don't use the platform device as parent for mpc8xxx.

Note however that I did several updates to the mpc8xxx driver which
probably conflict with setting the parent. I'll take care of that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
