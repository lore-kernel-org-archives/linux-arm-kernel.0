From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 7 Feb 2013 11:11:53 -0500 (EST)
Subject: [PATCH v2 14/14] USB: ehci-omap: Fix autoloading of module
In-Reply-To: <1360252974-7912-15-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1302071111401.1534-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Feb 2013, Roger Quadros wrote:

> The module alias should be "ehci-omap" and not
> "omap-ehci" to match the platform device name.
> The omap-ehci module should now autoload correctly.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index a8ce10d..a2d16c0 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -340,9 +340,10 @@ static void __exit ehci_omap_cleanup(void)
>  }
>  module_exit(ehci_omap_cleanup);
>  
> -MODULE_ALIAS("platform:omap-ehci");
> +MODULE_ALIAS("platform:ehci-omap");
>  MODULE_AUTHOR("Texas Instruments, Inc.");
>  MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com");
>  
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
> 
