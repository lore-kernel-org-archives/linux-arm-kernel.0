From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Jul 2015 14:16:27 +0300
Subject: [PATCH v2 48/48] usb: gadget: epautoconf: cleanup dead code
In-Reply-To: <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
Message-ID: <55A4EF8B.7090806@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> Function find_ep() is no longer needed here, so we can remove it.
> We also don't use anything from gadget_chips.h header any longer.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/epautoconf.c | 14 --------------
>   1 file changed, 14 deletions(-)

> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index e9a8682..9a80925 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -20,20 +20,6 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>
> -#include "gadget_chips.h"
> -
> -static struct usb_ep *
> -find_ep (struct usb_gadget *gadget, const char *name)
> -{
> -	struct usb_ep	*ep;
> -
> -	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> -		if (0 == strcmp (ep->name, name))
> -			return ep;
> -	}
> -	return NULL;
> -}
> -

    I don't think duplicating the function in each driver that needs it is 
better than turniong this function into public.

WBR, Sergei
