From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 05 Nov 2014 08:22:13 -0800
Subject: [PATCH V3 1/3] can: add can_is_canfd_skb() API
In-Reply-To: <1415193393-30023-1-git-send-email-b29396@freescale.com>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
Message-ID: <1415204533.13896.7.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-05 at 21:16 +0800, Dong Aisheng wrote:
> The CAN device drivers can use it to check if the frame to send is on
> CAN FD mode or normal CAN mode.
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
> ChangesLog:
>  * v1->v2: change to skb->len == CANFD_MTU;
> ---
>  include/linux/can/dev.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6992afc..4c3919c 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -99,6 +99,11 @@ inval_skb:
>  	return 1;
>  }
>  

This looks a bit strange to assume that skb->len == magical_value is CAN
FD. A comment would be nice.

> +static inline int can_is_canfd_skb(struct sk_buff *skb)

static inline bool can_is_canfd_skb(const struct sk_buff *skb)

> +{
> +	return skb->len == CANFD_MTU;
> +}
> +
>  /* get data length from can_dlc with sanitized can_dlc */
>  u8 can_dlc2len(u8 can_dlc);
>  
