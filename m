From: davem@davemloft.net (David Miller)
Date: Wed, 10 Dec 2014 15:15:50 -0500 (EST)
Subject: [PATCH] net/macb: add TX multiqueue support for gem
In-Reply-To: <1418223831-30435-2-git-send-email-cyrille.pitchen@atmel.com>
References: <1418223831-30435-1-git-send-email-cyrille.pitchen@atmel.com>
 <1418223831-30435-2-git-send-email-cyrille.pitchen@atmel.com>
Message-ID: <20141210.151550.855246066396941606.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Wed, 10 Dec 2014 16:03:51 +0100

> +	netdev_vdbg(bp->dev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
> +		    queue - bp->queues, queue->tx_tail, queue->tx_head);

This and another change int his patch adds build warnings because
"ptr1 - ptr2" is a ptrdiff_t, which is a long int on some platforms:

drivers/net/ethernet/cadence/macb.c: In function ?macb_tx_error_task?:
drivers/net/ethernet/cadence/macb.c:504:2: warning: format ?%u? expects argument of type ?unsigned int?, but argument 4 has type ?long int? [-Wformat]
drivers/net/ethernet/cadence/macb.c: In function ?macb_interrupt?:
drivers/net/ethernet/cadence/macb.c:988:3: warning: format ?%u? expects argument of type ?unsigned int?, but argument 4 has type ?long int? [-Wformat]
