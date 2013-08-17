From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:13:41 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <201308172108.38824.arnd@arndb.de>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130816204831.GX13964@titan.lakedaemon.net>
 <201308172108.38824.arnd@arndb.de>
Message-ID: <201308172113.41376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 August 2013, Arnd Bergmann wrote:
> On Friday 16 August 2013, Jason Cooper wrote:
> > > +

> 
> You should really try to find out what driver uses this. If you have a requirement
> that VIRT == PHYS here, the most likely explanation is that some driver accidentally
> uses readl/writel on the physical address rather than on the result of ioremap.
> 
> You can try shrinking the area using bisection until you have found the offending
> driver based on the address.
> 

> > > +static void __init armada_1500_timer_and_clk_init(void)
> 
> New platforms should call this as 'l2x0_of_init(0, 0);' and get the bits from DT.
> 
> Note that we should really change the common code to do both the of_clk_init()
> and the l2x0_of_init() automatically, but that needs to be done with some care,
> in order to not break any of the existing platforms. Would you be able to do
> one of the two? We can then get the next person that wants to add a platform
> to do the last one ;-)


I replied to the wrong mail. My comments were obviously meant for Sebastian,
not for Jason.

	Arnd
