From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Jun 2017 21:01:33 +0200
Subject: [PATCH] net/{mii,smsc}: Make mii_ethtool_get_link_ksettings and
 smc_netdev_get_ecmd return void
In-Reply-To: <20170604172200.4177-1-yuval.shaia@oracle.com>
References: <20170604172200.4177-1-yuval.shaia@oracle.com>
Message-ID: <20170604190133.GB10273@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
> index da02041..017f48c 100644
> --- a/drivers/net/cris/eth_v10.c
> +++ b/drivers/net/cris/eth_v10.c
> @@ -1417,10 +1417,9 @@ static int e100_get_link_ksettings(struct net_device *dev,
>  {
>  	struct net_local *np = netdev_priv(dev);
>  	u32 supported;
> -	int err;
>  
>  	spin_lock_irq(&np->lock);
> -	err = mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
> +	mii_ethtool_get_link_ksettings(&np->mii_if, cmd);
>  	spin_unlock_irq(&np->lock);
>  
>  	/* The PHY may support 1000baseT, but the Etrax100 does not.  */
> @@ -1432,7 +1431,7 @@ static int e100_get_link_ksettings(struct net_device *dev,
>  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
>  						supported);
>  
> -	return err;
> +	return 0;
>  }

How far are going planning on going? It seems like
*_get_link_ksettings() now all return a useless 0. Do you plan to
change ethtool_ops and make if void all the way up?

       Andrew
