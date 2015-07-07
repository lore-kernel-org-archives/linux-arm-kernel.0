From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 7 Jul 2015 17:10:32 +0300
Subject: [PATCH 4/5] staging: emxx_udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436277773-14274-5-git-send-email-r.baldyga@samsung.com>
References: <1436277773-14274-1-git-send-email-r.baldyga@samsung.com>
 <1436277773-14274-5-git-send-email-r.baldyga@samsung.com>
Message-ID: <559BDDD8.1060902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/7/2015 5:02 PM, Robert Baldyga wrote:

> Should use usb_ep_set_maxpacket_limit instead of setting
> maxpacket value manually.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/staging/emxx_udc/emxx_udc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 4178d96..f50bf5d 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -3203,7 +3203,8 @@ static void __init nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
>   		ep->ep.name = gp_ep_name[i];
>   		ep->ep.ops = &nbu2ss_ep_ops;
>
> -		ep->ep.maxpacket = (i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE);
> +		usb_ep_set_maxpacket_limit(&ep->ep,
> +				(i == 0 ? EP0_PACKETSIZE : EP_PACKETSIZE));

    Inner () not needed.

[...]

WBR, Sergei
