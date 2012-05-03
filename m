From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 03 May 2012 16:45:06 +0530
Subject: [PATCH 7/8] gpio/omap: remove cpu_is_omapxxxx() checks from
 *_runtime_resume()
In-Reply-To: <1335536018-16004-8-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-8-git-send-email-tarun.kanti@ti.com>
Message-ID: <4FA268BA.2040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> Add register offsets for GPIO_IRQSTATUS_RAW_0, GPIO_IRQSTATUS_RAW_0
> which are present on OMAP4+ processors. Now we can distinguish
> conditions applicable to OMAP4,5 and those specific to OMAP24xx
> and OMAP3xxx.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/gpio.c             |    2 ++
>  arch/arm/plat-omap/include/plat/gpio.h |    2 ++
>  drivers/gpio/gpio-omap.c               |    4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
Looks like this was the last cpu_is_*() in gpio driver.
Thanks for cleaning up this.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
