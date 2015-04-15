From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 16:19:59 +0200
Subject: [PATCH net-next 4/6] net: hip04: Don't free the tx skb when the
 buffer is not ready for xmit
In-Reply-To: <1429101008-9464-5-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
 <1429101008-9464-5-git-send-email-dingtianhong@huawei.com>
Message-ID: <2218546.M1hzu1bzfh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 20:30:06 Ding Tianhong wrote:
> @@ -489,6 +487,8 @@ static int hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>         /* Ensure tx_head update visible to tx reclaim */
>         smp_wmb();
> +       count++;
> +       priv->tx_head = TX_NEXT(tx_head);
>  
> 

Something is wrong here, the comment does not match the code any more, because
the smp_wmb() won't actually make the tx_head update visible.

	Arnd
