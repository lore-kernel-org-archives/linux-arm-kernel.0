From: greg@kroah.com (Greg KH)
Date: Mon, 12 Aug 2013 13:19:19 -0700
Subject: [PATCH V3 1/2] USB: OHCI: make ohci-ep93xx a separate driver
In-Reply-To: <1376120501-21368-2-git-send-email-manjunath.goudar@linaro.org>
References: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120501-21368-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120501-21368-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130812201919.GA26309@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 01:11:39PM +0530, Manjunath Goudar wrote:
> Separate the OHCI EP93XX host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>  -ohci_hcd_init() statements are removed,
>   because by default it is called in ohci_setup().
> 
> V3:
>  -Unused *ohci variable has been removed.
> ---
>  drivers/usb/host/Kconfig       |    8 ++++
>  drivers/usb/host/Makefile      |    1 +
>  drivers/usb/host/ohci-ep93xx.c |   80 +++++++++++++++++-----------------------
>  drivers/usb/host/ohci-hcd.c    |   18 ---------
>  4 files changed, 43 insertions(+), 64 deletions(-)

This too fails to apply:

$ p1 < ../s1
checking file drivers/usb/host/Kconfig
Hunk #1 FAILED at 414.
1 out of 1 hunk FAILED
checking file drivers/usb/host/Makefile
Hunk #1 FAILED at 54.
1 out of 1 hunk FAILED
checking file drivers/usb/host/ohci-ep93xx.c
Hunk #2 FAILED at 92.
Hunk #3 FAILED at 120.
Hunk #4 succeeded at 179 (offset -40 lines).
Hunk #5 succeeded@193 (offset -40 lines).
2 out of 5 hunks FAILED
checking file drivers/usb/host/ohci-hcd.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
3 out of 3 hunks ignored


Can you respin _all_ of your pending patches you have sent me in a
format that I can apply them, and resend them in a series that shows
what should be applied in which order.  As it is, I have 3-4 different
series of patches from you, with no obvious order which should be
applied in which order.  Because of that, that might be why these aren't
applying.

thanks,

greg k-h
