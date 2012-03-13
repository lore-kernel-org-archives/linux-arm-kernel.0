From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 13 Mar 2012 07:45:09 +0200
Subject: [PATCH v4 04/11] ep93xx: Use ioremap for backlight driver
In-Reply-To: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
Message-ID: <20120313054509.GC4596@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 09:48:15AM +1100, Ryan Mallon wrote:
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
> 
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
