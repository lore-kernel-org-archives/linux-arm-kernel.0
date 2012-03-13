From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 09:52:24 +0000
Subject: [PATCH v4 04/11] ep93xx: Use ioremap for backlight driver
In-Reply-To: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
Message-ID: <201203130952.24401.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Ryan Mallon wrote:
> The ep93xx backlight driver uses a single register within the
> framebuffer's register space. Currently the backlight driver uses a
> static IO mapping for the register since the memory cannot be
> requested by both drivers.
> 
> Convert the static mapping to use ioremap so that we can remove the
> dependency on mach/hardware.h. To do so, we need remove the
> request_mem_region from both the backlight and framebuffer drivers,
> since whichever driver is loaded second will fail with -EBUSY
> otherwise.
> 
> A proper fix is still required, and a FIXME comment has been added to
> both drivers.

Acked-by: Arnd Bergmann <arnd@arndb.de>
