From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Oct 2014 17:37:00 +0200
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20141021152034.GA26186@fifteen>
References: <20140726155659.GA22977@fifteen> <20140726165620.GA29269@lunn.ch>
 <20140726171253.GA10370@fifteen>
 <20141021161551.127321bc@free-electrons.com>
 <20141021152034.GA26186@fifteen>
Message-ID: <20141021173700.207475d8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Evgeniy Dushistov,

On Tue, 21 Oct 2014 19:20:34 +0400, Evgeniy Dushistov wrote:

> > So you're still using the mainline kernel on this system?
> 
> Yes, we reuse old hardware design with new enougth (3.12) kernel.

Ok. And are you interested in seeing the mv78xx0 support being kept in
the mainline kernel for the foreseeable future?

> >We were
> > actually starting to consider getting rid of the support for this
> > platform, since it doesn't receive much attention, and there are almost
> > no systems supported in mainline that use this CPU.
> > 
> > Are you actually using the two CPUs on mv78200 ? If so, in what
> > configurations ?
> > 
> 
> We use several configurations, on some of them the second cpu is disabled,
> on others the second CPU connected to the first via gigabit ethernet 
> (eth2<->eth3 in loopback like mode [I fixed one bug several years ago
> about usage of such config, it should be in mainline]).

Ok.

> > Would you be willing to put some effort into moving mv78xx0 to the
> > Device Tree, and all other modern subsystems (clock, pinmux, etc.) ?
> > 
> 
> At now I have several git branches for slightly different device
> configurations, so I suppose support of Device Tree should simplify
> things for me.
> 
> But I can only test it on mv78200 CPU, and only
> compiled into the kernel, because of u-boot from marvell old enough(no
> Device Tree support),
> and not sure that mainstream u-boot support the usage of two cores.

Right, you probably have no other choice but keeping the original
U-Boot. But that's fine, with appended DTB, you can use this old U-Boot
and boot modern kernels.

But are you interested in helping doing this migration, but sending
some patches, doing some testing and so on?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
