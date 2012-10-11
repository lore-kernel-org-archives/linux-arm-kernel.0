From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 13:35:42 +0000
Subject: alignment faults in 3.6
In-Reply-To: <5076C78E.1020408@gmail.com>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <1349959248.21172.8970.camel@edumazet-glaptop> <5076C78E.1020408@gmail.com>
Message-ID: <201210111335.43177.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, Rob Herring wrote:
> 
> On 10/11/2012 07:40 AM, Eric Dumazet wrote:
> > On Thu, 2012-10-11 at 12:28 +0000, Arnd Bergmann wrote:
> > 
> >>
> >> Rob Herring as the original reporter has dropped off the Cc list, adding
> >> him back.
> >>
> >> I assume that the calxeda xgmac driver is the culprit then. It uses
> >> netdev_alloc_skb() rather than netdev_alloc_skb_ip_align() in
> >> xgmac_rx_refill but it is not clear whether it does so intentionally
> >> or by accident.
> 
> This in fact does work and eliminates the unaligned traps. However, not
> all h/w can do IP aligned DMA (i.MX FEC for example), so I still think
> this is a questionable optimization by the compiler. We're saving 1 load
> instruction here for data that is likely already in the cache. It may be
> legal per the ABI, but the downside of this optimization is much greater
> than the upside.
> 

What about the other approach that Eric suggested for such hardware
in http://www.spinics.net/lists/arm-kernel/msg200206.html ?

	Arnd
