From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed, 18 Aug 2010 10:33:35 +0200
Subject: [PATCH v2] ether1: Use net_device_stats from struct net_device
In-Reply-To: <1282120073.2194.40.camel@edumazet-laptop>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
	<20100818081306.GA9149@n2100.arm.linux.org.uk>
	<1282120073.2194.40.camel@edumazet-laptop>
Message-ID: <20100818083335.GH15670@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-18 at 10:27:53 +0200, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> Le mercredi 18 ao?t 2010 ? 09:13 +0100, Russell King - ARM Linux a
> ?crit :
> > On Wed, Aug 18, 2010 at 09:04:24AM +0200, Tobias Klauser wrote:
> > > @@ -965,7 +965,7 @@ ether1_close (struct net_device *dev)
> > >  static struct net_device_stats *
> > >  ether1_getstats (struct net_device *dev)
> > >  {
> > > -	return &priv(dev)->stats;
> > > +	return &dev->stats;
> > >  }
> > 
> > Doesn't the core do this for you already if you omit this function?
> > 
> > Same comment for ether3.c
> 
> Yes, thats right, no need to declare ndo_get_stats() methods that only
> returns &dev->stats

Thanks. I'll send another updated patch, omitting the ether1_getstats
(same for ether3). Sorry for the mess.
