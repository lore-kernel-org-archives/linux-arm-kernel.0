From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Oct 2011 11:28:05 -0400 (EDT)
Subject: [PATCH] fix ehci alignment error
In-Reply-To: <20111010124154.464239811@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1110101127240.18069-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Oct 2011, Harro Haan wrote:

> The Kirkwood gave an unaligned memory access error on
> line 742 of drivers/usb/host/echi-hcd.c:
> "ehci->last_periodic_enable = ktime_get_real();"
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> ---
>  include/linux/usb/hcd.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 0097136..c0ecc5a 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -178,7 +178,7 @@ struct usb_hcd {
>  	 * this structure.
>  	 */
>  	unsigned long hcd_priv[0]
> -			__attribute__ ((aligned(sizeof(unsigned long))));
> +			__attribute__ ((aligned(sizeof(s64))));
>  };
>  
>  /* 2.4 does this a bit differently ... */

Acked-by: Alan Stern <stern@rowland.harvard.edu>
