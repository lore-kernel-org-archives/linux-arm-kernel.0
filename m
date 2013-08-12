From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 12 Aug 2013 13:17:10 -0700
Subject: [PATCH V2] USB: EHCI: make ehci-w90X900 a separate driver
In-Reply-To: <1376120073-30502-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372347109-5563-1-git-send-email-manjunath.goudar@linaro.org>
 <1376120073-30502-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130812201710.GA26239@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 01:04:33PM +0530, Manjunath Goudar wrote:
> Separate the W90X900(W90P910) on-chip host controller driver from
> ehci-hcd host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> however, note that other changes are still needed before W90X900(W90P910)
> can be booted with a multi-platform kernel
> 
> and an ehci driver that only works on one of them.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the w90X900 bus glue.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> 
> V2:
> -Arranged  #include's in alphabetical order.
> -Replaced "w90p910" by "w90x900" because it is supports
>  all series of w90x900.
> 
>  drivers/usb/host/Kconfig        |    2 +-
>  drivers/usb/host/Makefile       |    1 +
>  drivers/usb/host/ehci-hcd.c     |    5 ---
>  drivers/usb/host/ehci-w90x900.c |   85 ++++++++++++++++-----------------------
>  4 files changed, 37 insertions(+), 56 deletions(-)

This patch fails to apply:

checking file drivers/usb/host/Kconfig
Hunk #1 succeeded at 236 with fuzz 1 (offset -8 lines).
checking file drivers/usb/host/Makefile
Hunk #1 FAILED at 35.
1 out of 1 hunk FAILED
checking file drivers/usb/host/ehci-hcd.c
Hunk #1 succeeded at 1246 (offset -3 lines).
checking file drivers/usb/host/ehci-w90x900.c
Hunk #2 FAILED at 114.
1 out of 3 hunks FAILED

Please redo it against the latest usb-next branch and resend.

thanks,

greg k-h
