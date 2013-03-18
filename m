From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 10:58:51 +0000
Subject: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
In-Reply-To: <CAHkwnC9YFTw8gVzyZB3_gZCgM5zMA6tLch15EDqcA2F4CAOpAQ@mail.gmail.com>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <201303152018.09094.arnd@arndb.de>
 <CAHkwnC9YFTw8gVzyZB3_gZCgM5zMA6tLch15EDqcA2F4CAOpAQ@mail.gmail.com>
Message-ID: <201303181058.51641.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Fabio Porcedda wrote:
> Since by using platform_driver_probe() the  function
> ep93xx_pwm_probe() is freed after initialization,
> is better to use module_platform_drive_probe().
> IMHO i don't see any good reason to use module_platform_driver() for
> this driver.

As I commented earlier, the platform_driver_probe() and
module_platform_drive_probe() interfaces are rather dangerous in combination
with deferred probing, I would much prefer Harley's patch.

	Arnd
