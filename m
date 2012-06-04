From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 4 Jun 2012 16:16:52 -0400 (EDT)
Subject: [PATCH] ohci-hub: Mark ohci_finish_controller_resume() as
 __maybe_unused
In-Reply-To: <1338837608-23976-1-git-send-email-stigge@antcom.de>
Message-ID: <Pine.LNX.4.44L0.1206041616300.1555-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jun 2012, Roland Stigge wrote:

> ohci_finish_controller_resume() is intended to be used in platform specific
> drivers ohci-*.c, included from ohci-hcd.c. Some of them don't actually use
> ohci_finish_controller_resume(), so mark it as __maybe_unused.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ohci-hub.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.orig/drivers/usb/host/ohci-hub.c
> +++ linux-2.6/drivers/usb/host/ohci-hub.c
> @@ -317,7 +317,7 @@ static int ohci_bus_resume (struct usb_h
>  }
>  
>  /* Carry out the final steps of resuming the controller device */
> -static void ohci_finish_controller_resume(struct usb_hcd *hcd)
> +static void __maybe_unused ohci_finish_controller_resume(struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
>  	int			port;
> 
> 
