From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Wed, 05 Nov 2014 10:39:16 +0100
Subject: [PATCH V1 3/4] can: add can_is_canfd_skb() API
In-Reply-To: <1415174326-6623-3-git-send-email-b29396@freescale.com>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
 <1415174326-6623-3-git-send-email-b29396@freescale.com>
Message-ID: <5459F044.3090902@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2014 08:58, Dong Aisheng wrote:
> The CAN device drivers can use it to check if the frame to send is on
> CAN FD mode or normal CAN mode.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>   include/linux/can/dev.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6992afc..fe3be29 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -99,6 +99,11 @@ inval_skb:
>   	return 1;
>   }
>
> +static inline int can_is_canfd_skb(struct sk_buff *skb)
> +{
> +	return skb->protocol == htons(ETH_P_CANFD);

return skb->len == CANFD_MTU;

Please take the length as distinction as we do it in linux/net/can/ too.

You can add my

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

in the updated post then.

Regards,
Oliver
