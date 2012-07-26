From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2012 11:45:51 +0200
Subject: [patch 1/1] kirkwood: set tx_csum_limit
In-Reply-To: <87r4ry98i0.fsf@lebrac.rtp-net.org>
References: <20120726071240.690145078@rtp-net.org> <1719571.FAPWHj9hMz@flexo>
 <87r4ry98i0.fsf@lebrac.rtp-net.org>
Message-ID: <20120726094551.GA14943@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>  	orion_ge00_init(eth_data, DOVE_GE00_PHYS_BASE,
> >> -			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR);
> >> +			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR, 0);
> >>  }
> >
> > You might want to add a constant for TX_CSUM_NO_LIMIT or something like that, 
> > rather than a plain 0 which might be a little misleading.
> >
> 
> It's not to set an unlimited value but to tell the driver it has to
> use its default value. This limit is only valid for kirkwood but given
> that orion_ge*_init functions are used on all platforms, I have to set 

So how about TX_CSUM_DEFAULT_LIMIT?

It would also be nice if you could change the change log text to
something like:

ARM: Orion: Set eth packet size csum offload limit

The mv643xx ethernet controller limits the packet size for the TX
checksum offloading. This patch sets this limits for Kirkwood and
Dove which have smaller limits that the default.

I would like to consistently use the prefixes:

ARM: Orion: 
ARM: Kirkwood:
ARM: Dove:
ARM: Orion5x:
...

   Thanks
	Andrew
