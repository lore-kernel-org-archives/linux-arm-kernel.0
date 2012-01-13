From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:54:52 -0600
Subject: [PATCH 11/11] ep93xx: Remove unnecessary includes of ep93xx-regs.h
In-Reply-To: <1326251676-7593-12-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-12-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBB19@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
> 
> Remove the include of ep93xx-regs.h from files which no longer need
> it, notably include/mach/hardware.h. An explict include of ep93xx-regs.h
>  is needed in the EP93xx watchdog driver for the EP93XX_APB_IOMEM macro.
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/crunch.c                |    2 +-
>  arch/arm/mach-ep93xx/include/mach/hardware.h |    1 -
>  arch/arm/mach-ep93xx/soc.h                   |    2 ++
>  drivers/watchdog/ep93xx_wdt.c                |    1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)

My patch to convert the watchdog driver to a platform device using the
WatchDog Timer Core will also remove the need to include ep93xx-regs.h.

But for now this looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
