From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 17:38:44 -0500
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
References: <201302152158.23446.arnd@arndb.de>
 <1360966349-1242560-1-git-send-email-arnd@arndb.de>
 <1360966349-1242560-2-git-send-email-arnd@arndb.de>
Message-ID: <20130215223844.GN14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 11:12:29PM +0100, Arnd Bergmann wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> With the multiplatform changes in arm-soc tree, it becomes
> possible to enable the mvebu platform (which uses
> ehci-orion) at the same time as other platforms that require
> a conflicting EHCI bus glue. At the moment, this results
> in a warning like
> 
> drivers/usb/host/ehci-hcd.c:1297:0: warning: "PLATFORM_DRIVER" redefined [enabled by default]
> drivers/usb/host/ehci-hcd.c:1277:0: note: this is the location of the previous definition
> drivers/usb/host/ehci-orion.c:334:31: warning: 'ehci_orion_driver' defined but not used [-Wunused-variable]
> 
> and an ehci driver that only works on one of them.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the orion bus glue.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/usb/host/Kconfig      |  8 ++++
>  drivers/usb/host/Makefile     |  1 +
>  drivers/usb/host/ehci-hcd.c   |  6 +--
>  drivers/usb/host/ehci-orion.c | 90 ++++++++++++++++++++-----------------------
>  4 files changed, 52 insertions(+), 53 deletions(-)

This looks sane to me, but I unfortunately don't have time to test atm.
So if Arnd has been working with you:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
