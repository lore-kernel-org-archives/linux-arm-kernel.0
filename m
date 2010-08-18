From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Aug 2010 09:13:07 +0100
Subject: [PATCH v2] ether1: Use net_device_stats from struct net_device
In-Reply-To: <1282115064-3701-1-git-send-email-tklauser@distanz.ch>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20100818081306.GA9149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 09:04:24AM +0200, Tobias Klauser wrote:
> @@ -965,7 +965,7 @@ ether1_close (struct net_device *dev)
>  static struct net_device_stats *
>  ether1_getstats (struct net_device *dev)
>  {
> -	return &priv(dev)->stats;
> +	return &dev->stats;
>  }

Doesn't the core do this for you already if you omit this function?

Same comment for ether3.c
