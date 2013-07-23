From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Jul 2013 14:45:48 -0400 (EDT)
Subject: [PATCH 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1374484770-24531-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307231445230.1304-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.12.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>  -Set non-standard fields in ohci_at91_hc_driver manually, rather than
>   relying on an expanded struct ohci_driver_overrides.
>  -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
>   relying on ohci_hub_control and hub_status_data being exported.
>  -ohci_setup() has been removed because it is called in .reset member
>   of the ohci_hc_driver structure.
> 
> V3:
>  -The ohci_restart() function is not required in  current scenario,
>   only discarding connection state of integrated transceivers is sufficient,
>   for this directly handling ohci->hc_control.
> 
> V4:
>  - Removed extra space after "tristate".
>  - Removed extra space between function name  and '(' characters.
>  - MODULE_ALIAS line moved to last statement of ohci-at91 file.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
