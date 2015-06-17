From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 17 Jun 2015 09:07:30 -0700
Subject: [PATCH] xilinx:Remove unused variable num_frag in the function
 axienet_start_xmit
In-Reply-To: <1434556362-3748-1-git-send-email-xerofoify@gmail.com>
References: <1434556362-3748-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150617160730.GE2906@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-17 at 11:52AM -0400, Nicholas Krause wrote:
> This removes the unused variable num_frag and the setting of it
> to the number of fragments from the passed sk_buff pointer by
> this function's caller due to this variable never being used
> in this particular function and is not declared as  global so
> setting it for global use in this file is pointless.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 28b7e7d..624dce4 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -651,7 +651,6 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
>  static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	u32 ii;
> -	u32 num_frag;
>  	u32 csum_start_off;
>  	u32 csum_index_off;
>  	skb_frag_t *frag;
> @@ -659,7 +658,6 @@ static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct axienet_local *lp = netdev_priv(ndev);
>  	struct axidma_bd *cur_p;
>  
> -	num_frag = skb_shinfo(skb)->nr_frags;
>  	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
>  
>  	if (axienet_check_tx_bd_space(lp, num_frag)) {

It's used right here, isn't it (and further down in this function too)?
Does your tree compile with this change?

	S?ren
