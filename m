From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 May 2017 08:11:03 -0700
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <20170525144800.GV23750@n2100.armlinux.org.uk>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
Message-ID: <20170525151103.GC10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170525 07:51]:
> On Wed, May 24, 2017 at 08:38:47AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@armlinux.org.uk> [170519 10:19]:
> > > We could expand the table to positively identify the SMP capable CPUs
> > > and enable the SMP bit there, but it's going to add a lot of entries
> > > there (one for each specific ARMv7 MP CPU) and is going to have to be
> > > endlessly added to each time a new SMP CPU comes out.
> > 
> > Looks like commit e414690faa81 ("ARM: always enable SMP mode on SMP cores")
> > causes booting to fail early at least on omap4430 duovero. It's a bit of
> > a mystery as it is SMP.. And pandboard es (4460) and droid 4 (4430) work
> > without the conditional write..
> > 
> > Partial revert like below seems to make it boot again.
> 
> Thanks for testing, I'll integrate your change, and it should be in
> tonight's linux-next.

OK. That may not work on am437x though as it's UP.

Afzal, did the change that I posted work for you?

Regards,

Tony
