From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Mar 2012 11:49:54 -0500
Subject: [PATCH v4 04/11] ep93xx: Use ioremap for backlight driver
In-Reply-To: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695AB97F3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 12, 2012 3:48 PM, Ryan Mallon wrote:
>
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
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  arch/arm/mach-ep93xx/core.c         |   10 ++++++++++
>  drivers/video/backlight/ep93xx_bl.c |   25 ++++++++++++++-----------
>  drivers/video/ep93xx-fb.c           |   15 +++++++++------
>  3 files changed, 33 insertions(+), 17 deletions(-)

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
