From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 18 Aug 2010 10:27:53 +0200
Subject: [PATCH v2] ether1: Use net_device_stats from struct net_device
In-Reply-To: <20100818081306.GA9149@n2100.arm.linux.org.uk>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
	<20100818081306.GA9149@n2100.arm.linux.org.uk>
Message-ID: <1282120073.2194.40.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 18 ao?t 2010 ? 09:13 +0100, Russell King - ARM Linux a
?crit :
> On Wed, Aug 18, 2010 at 09:04:24AM +0200, Tobias Klauser wrote:
> > @@ -965,7 +965,7 @@ ether1_close (struct net_device *dev)
> >  static struct net_device_stats *
> >  ether1_getstats (struct net_device *dev)
> >  {
> > -	return &priv(dev)->stats;
> > +	return &dev->stats;
> >  }
> 
> Doesn't the core do this for you already if you omit this function?
> 
> Same comment for ether3.c

Yes, thats right, no need to declare ndo_get_stats() methods that only
returns &dev->stats
