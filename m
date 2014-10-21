From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Oct 2014 16:15:51 +0200
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20140726171253.GA10370@fifteen>
References: <20140726155659.GA22977@fifteen> <20140726165620.GA29269@lunn.ch>
 <20140726171253.GA10370@fifteen>
Message-ID: <20141021161551.127321bc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Evgeniy Dushistov,

On Sat, 26 Jul 2014 21:12:53 +0400, Evgeniy Dushistov wrote:
> On Sat, Jul 26, 2014 at 06:56:20PM +0200, Andrew Lunn wrote:
> > On Sat, Jul 26, 2014 at 07:56:59PM +0400, Evgeniy Dushistov wrote:
> > > The problem is that hardware handled by arm/plat-orion/gpio.c,
> > > require ack for edge irq, and no ack for level irq.
> > 
> > Hi Evgeniy
> > 
> > Thanks for the problem report and patch. What device are you using?
> > An Orion5x based board or mv78xx0? Those are the only two left using
> > this code.
> 
> I used custom board with mv78200 CPU.

So you're still using the mainline kernel on this system? We were
actually starting to consider getting rid of the support for this
platform, since it doesn't receive much attention, and there are almost
no systems supported in mainline that use this CPU.

Are you actually using the two CPUs on mv78200 ? If so, in what
configurations ?

Would you be willing to put some effort into moving mv78xx0 to the
Device Tree, and all other modern subsystems (clock, pinmux, etc.) ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
