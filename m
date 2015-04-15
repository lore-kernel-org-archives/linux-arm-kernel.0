From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 16:14:26 +0200
Subject: [PATCH net-next 5/6] net: hip04: remove the unnecessary check
In-Reply-To: <1429101008-9464-6-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
 <1429101008-9464-6-git-send-email-dingtianhong@huawei.com>
Message-ID: <2645626.sX8mP7tn7R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 20:30:07 Ding Tianhong wrote:
> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index ff9d19c..a7ab1d9 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -440,7 +440,7 @@ static int hip04_tx_reclaim(struct net_device *ndev, bool force)
>         smp_wmb(); /* Ensure tx_tail visible to xmit */
>  
>  out:
> -       if (pkts_compl || bytes_compl)
> +       if (bytes_compl)
>                 netdev_completed_queue(ndev, pkts_compl, bytes_compl);
>  
>         if (unlikely(netif_queue_stopped(ndev)) && (count < (TX_DESC_NUM - 1)))
> -- 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
