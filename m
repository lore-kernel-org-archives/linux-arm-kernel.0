From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Tue, 21 Oct 2014 19:20:34 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20141021161551.127321bc@free-electrons.com>
References: <20140726155659.GA22977@fifteen> <20140726165620.GA29269@lunn.ch>
 <20140726171253.GA10370@fifteen>
 <20141021161551.127321bc@free-electrons.com>
Message-ID: <20141021152034.GA26186@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 04:15:51PM +0200, Thomas Petazzoni wrote:
> > I used custom board with mv78200 CPU.
> 
> So you're still using the mainline kernel on this system?

Yes, we reuse old hardware design with new enougth (3.12) kernel.

>We were
> actually starting to consider getting rid of the support for this
> platform, since it doesn't receive much attention, and there are almost
> no systems supported in mainline that use this CPU.
> 
> Are you actually using the two CPUs on mv78200 ? If so, in what
> configurations ?
> 

We use several configurations, on some of them the second cpu is disabled,
on others the second CPU connected to the first via gigabit ethernet 
(eth2<->eth3 in loopback like mode [I fixed one bug several years ago
about usage of such config, it should be in mainline]).


> Would you be willing to put some effort into moving mv78xx0 to the
> Device Tree, and all other modern subsystems (clock, pinmux, etc.) ?
> 

At now I have several git branches for slightly different device
configurations, so I suppose support of Device Tree should simplify
things for me.

But I can only test it on mv78200 CPU, and only
compiled into the kernel, because of u-boot from marvell old enough(no
Device Tree support),
and not sure that mainstream u-boot support the usage of two cores.


-- 
/Evgeniy
