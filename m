From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 03 Oct 2011 09:53:50 +0300
Subject: [PATCH 02/30] video/omap: fix dependencies
In-Reply-To: <1317566760-25681-3-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-3-git-send-email-arnd@arndb.de>
Message-ID: <1317624830.2026.6.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sun, 2011-10-02 at 16:45 +0200, Arnd Bergmann wrote:
> The lcd_2430sdp and lcd_ldp drivers depend on TWL4030, which is not
> well expressed in the Kconfig. Create new configuration options for
> these in order to describe the dependencies correctly.
> 
> In some cases, the driver cannot be a loadable module, so better
> force it to be built-in.
> 
> While we're at it, simplify the Makefile syntax.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap/Kconfig  |   41 +++++++++++++++++++++++++---
>  drivers/video/omap/Makefile |   64 ++++++++++++++++++++-----------------------
>  2 files changed, 67 insertions(+), 38 deletions(-)

I have ported lcd_2430sdp and lcd_ldp drivers (and also other OMAP2/3
panel drivers, except N800) to the newer omapdss driver
(drivers/video/omap2), and the code is in my for-next branch
(git://gitorious.org/linux-omap-dss2/linux.git for-next).

I have also worked on removing OMAP2/3 support from the old omapfb
driver, thus making it OMAP1 fb driver. This code is not yet ready, and
won't make it in the next merge window.

Your patch will conflict with both of those changes. Is it ok for you to
drop this patch, and I'll make a new one on top of my changes to clean
up the Makefile in a similar way than you did? The new patch wouldn't
make it in the next merge window, though, but I don't think this patch
is fixing any bigger bug, so perhaps it's not so urgent.

 Tomi
