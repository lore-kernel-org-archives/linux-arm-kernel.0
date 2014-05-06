From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 May 2014 10:40:14 -0500
Subject: [PATCH v3 04/20] usb: xhci: add a platform-private field
In-Reply-To: <1399335255-589-5-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140506154014.GG25849@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 02:13:59AM +0200, Gregory CLEMENT wrote:
> This patch adds an xhci->priv field for private use by xHCI platform
> drivers. This field was present for OHCI and EHCI and it was not
> needed until now for xHCI. With the introduction of the clock support,
> then a private field will be useful, so let's mimic what have been
> done for the other HCI.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/host/xhci.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index d280e9213d08..054017f66246 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1584,6 +1584,9 @@ struct xhci_hcd {
>  	u32			port_status_u0;
>  /* Compliance Mode Timer Triggered every 2 seconds */
>  #define COMP_MODE_RCVRY_MSECS 2000
> +
> +	/* platform-specific data -- must come last */
> +	unsigned long		priv[0] __aligned(sizeof(s64));
>  };
>  
>  /* convert between an HCD pointer and the corresponding EHCI_HCD */
> -- 
> 1.8.1.2
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/473d47df/attachment-0001.sig>
