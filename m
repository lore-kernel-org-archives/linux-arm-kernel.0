From: davem@davemloft.net (David Miller)
Date: Sat, 02 Feb 2013 23:08:51 -0500 (EST)
Subject: [PATCH 1/1] net: fec: fix miss init spinlock
In-Reply-To: <1359708986-23634-1-git-send-email-Frank.Li@freescale.com>
References: <1359708986-23634-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130202.230851.809969826800130930.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Fri, 1 Feb 2013 16:56:26 +0800

> @@ -1607,6 +1607,7 @@ static int fec_enet_init(struct net_device *ndev)
>  	}
>  
>  	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->tmreg_lock);

This breaks the build, tmreg_lock is only present in certain
configurations.
