From: davem@davemloft.net (David Miller)
Date: Tue, 10 Jan 2017 21:24:57 -0500 (EST)
Subject: [PATCH net-next 5/8] net: dsa: Export dev_to_net_device()
In-Reply-To: <20170110201235.21771-6-f.fainelli@gmail.com>
References: <20170110201235.21771-1-f.fainelli@gmail.com>
 <20170110201235.21771-6-f.fainelli@gmail.com>
Message-ID: <20170110.212457.38085718141908018.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 10 Jan 2017 12:12:32 -0800

> @@ -491,7 +491,7 @@ struct mii_bus *dsa_host_dev_to_mii_bus(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dsa_host_dev_to_mii_bus);
>  
> -static struct net_device *dev_to_net_device(struct device *dev)
> +struct net_device *dev_to_net_device(struct device *dev)
>  {
>  	struct device *d;
>  
> @@ -508,6 +508,7 @@ static struct net_device *dev_to_net_device(struct device *dev)
>  
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(dev_to_net_device);

Something like this, a public interface with a very high level generic name,
doesn't belong in the DSA layer.  It belongs in net/core/dev.c or something
like that.
