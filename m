From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 19 Oct 2013 14:22:13 -0700
Subject: [PATCH 2/2 v4] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <201310171329.12434.hartleys@visionengravers.com>
References: <201310171329.12434.hartleys@visionengravers.com>
Message-ID: <20131019212213.GA5341@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 01:29:11PM -0700, H Hartley Sweeten wrote:
> Convert ep93xx to use the OHCI platform driver and remove the
> ohci-ep93xx bus glue driver.
> 
> Enable CONFIG_OHCI_HCD_PLATFORM in the ep93xx_defconfig so that USB
> is still enabled by default on the EP93xx platform.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/configs/ep93xx_defconfig |   1 +
>  arch/arm/mach-ep93xx/clock.c      |   2 +-
>  arch/arm/mach-ep93xx/core.c       |  38 +++++++-
>  drivers/usb/host/ohci-ep93xx.c    | 184 --------------------------------------
>  drivers/usb/host/ohci-hcd.c       |  18 ----
>  5 files changed, 36 insertions(+), 207 deletions(-)
>  delete mode 100644 drivers/usb/host/ohci-ep93xx.c

This patch doesn't apply to my usb-next branch of usb.git at all, what
happened?  Did Alan's other recent changes interfere with this?

Can you refresh this against my tree and resend it so that I can apply
it?  I've applied the 1/2 patch already.

thanks,

greg k-h
