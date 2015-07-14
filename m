From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Jul 2015 14:14:54 +0300
Subject: [PATCH v2 45/48] usb: gadget: net2280: add net2280_match_ep()
 function
In-Reply-To: <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
Message-ID: <55A4EF2E.9090306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
> process. Functions does the same that was done by chip-specific code inside
> of epautoconf. Now this code can be removed from there to separate generic code
> from platform specific logic.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

[...]
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 0295cf7..4933321 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -1533,6 +1533,49 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
>   	return 0;
>   }
>
> +static struct usb_ep *net2280_find_ep(struct usb_gadget *_gadget,
> +		const char *name)

    Shouldn't this be a generic function as before?

> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &_gadget->ep_list, ep_list) {
> +		if (0 == strcmp(ep->name, name))

    Please make 0 the 2nd operand to ==.

> +			return ep;
> +	}
> +
> +	return NULL;
> +}
[...]

WBR, Sergei
