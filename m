From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 25 Jun 2013 14:14:31 -0400 (EDT)
Subject: [PATCH V3 3/6] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1372141408-9894-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306251411190.1340-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Manjunath Goudar wrote:

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

You weren't supposed to remove it!  I told you to remove this one line:

	writel(OHCI_CTRL_RWC, &ohci->regs->control);

The preceding lines:

	/*
	 * RemoteWakeupConnected has to be set explicitly before
	 * calling ohci_run. The reset value of RWC is 0.
	 */
	ohci->hc_control = OHCI_CTRL_RWC;

should remain.

Alan Stern
