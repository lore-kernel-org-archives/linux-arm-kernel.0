From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Jul 2013 14:43:12 -0400 (EDT)
Subject: [PATCH 3/6] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1374484770-24531-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307231442040.1304-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP3 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure.
>  -The improper multi-line commenting style written in proper way.
>   ('*' characters aligned in vertically).
> 
> V3:
>  -RemoteWakeupConnected setting has been removed.
> 
> V4:
>  -V3 modification revert back, only ohci->regs setting write()
>   function has been removed because ohci->regs doesn't get set until
>   usb_add_hcd.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
