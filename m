From: gadiyar@ti.com (Gadiyar, Anand)
Date: Thu, 11 Mar 2010 23:50:49 +0530
Subject: [PATCH 2/3] usb: Fix USB_SUSPEND dependency for OTG
In-Reply-To: <20100311180329.20537.95308.stgit@baageli.muru.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321EC93DC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote:
> 
> To use this, PM_RUNTIME must be set as discussed at:
> 
> http://thread.gmane.org/gmane.linux.usb.general/27432/focus=4460
> 
> Otherwise we'll get errors like:
> 
> drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
> drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
> drivers/usb/core/hcd.c:1892: error: for each function it appears in.)
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Hi Tony,

I already posted this patch last month. Still waiting for it
to get queued.

<http://marc.info/?l=linux-usb&m=126675883221098&w=2>

- Anand


> ---
>  drivers/usb/core/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 97a819c..7e59444 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -109,7 +109,7 @@ config USB_SUSPEND
>  config USB_OTG
>  	bool
>  	depends on USB && EXPERIMENTAL
> -	select USB_SUSPEND
> +	depends on USB_SUSPEND
>  	default n
>  
>  
> 
