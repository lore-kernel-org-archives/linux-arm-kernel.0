From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 11 Apr 2013 13:25:40 -0700
Subject: [PATCH 10/30] usb: exynos: do not include plat/usb-phy.h
In-Reply-To: <1365638712-1028578-11-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-11-git-send-email-arnd@arndb.de>
Message-ID: <20130411202540.GA32047@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:04:52AM +0200, Arnd Bergmann wrote:
> The definitions have moved to include/linux/usb/samsung-usb-phy.h,
> and plat/usb-phy.h is unavailable from drivers in a multiplatform
> configuration.
> 
> Also fix up the plat/usb-phy.h header file to use the definitions
> from the new header instead of providing a separate copy.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-usb at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  arch/arm/mach-exynos/setup-usb-phy.c         | 8 ++++----
>  arch/arm/mach-s3c64xx/setup-usb-phy.c        | 4 ++--
>  arch/arm/mach-s5pv210/setup-usb-phy.c        | 4 ++--
>  arch/arm/plat-samsung/include/plat/usb-phy.h | 5 +----
>  drivers/usb/host/ehci-s5p.c                  | 1 -
>  drivers/usb/host/ohci-exynos.c               | 1 -
>  6 files changed, 9 insertions(+), 14 deletions(-)

This patch doesn't apply to my usb-next tree due to the other changes in
these files.

Care to refresh it and resend it?  I'll be glad to apply it then.

thanks,

greg k-h
