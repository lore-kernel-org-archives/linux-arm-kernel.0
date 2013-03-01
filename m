From: davem@davemloft.net (David Miller)
Date: Fri, 01 Mar 2013 15:58:59 -0500 (EST)
Subject: [PATCH v2 1/1 net-next] fec: net: put tx to napi poll function
 to fix dead lock
In-Reply-To: <1362109034-25805-1-git-send-email-Frank.Li@freescale.com>
References: <1362109034-25805-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130301.155859.2106303756469493825.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Fri, 1 Mar 2013 11:37:14 +0800

> @@ -566,27 +554,47 @@ fec_timeout(struct net_device *ndev)
>  	netif_wake_queue(ndev);
>  }
>  
> -static void
> +static int
>  fec_enet_tx(struct net_device *ndev)

The return value of this function is never tested, get rid of it.
