From: w@1wt.eu (Willy Tarreau)
Date: Sat, 6 Apr 2013 23:54:43 +0200
Subject: [PATCH] ARM: makefile: add tuning options for Armada 370/XP
In-Reply-To: <5160982C.9090702@free-electrons.com>
References: <20130406192957.GQ11459@1wt.eu>
 <5160982C.9090702@free-electrons.com>
Message-ID: <20130406215443.GT11459@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gr?gory,

On Sat, Apr 06, 2013 at 11:48:28PM +0200, Gregory CLEMENT wrote:
> Hi Willy,
> 
> On 04/06/2013 09:29 PM, Willy Tarreau wrote:
> > Hi,
> > 
> > A patch from Marvell was merged in GCC 4.8 to add support for their
> > PJ4 CPU core used in Armada370 and XP. I noticed a steady 2% network
> > performance increase using -mcpu=marvell-pj4 and around 1% when using
> > -mtune=xscale instead. I have no idea whether it provides anything to
> > the Dove platform and I don't have one to test, so I didn't touch it.
> > 
> > Now that 4.8 is released, it would be nice to have this option used
> > when supported.
> 
> Sure it will be very nice! But what happens when the kernel is built
> in multiarch?
> It seems to me that in this case gcc will tune the code for PJ4 whereas
> the kernel built can also be run on a Cortex-A, a Scorpion or a Krait.

I have not thought about that. Maybe we're already reaching the limits of
the multiarch mode ? After all, pj4 is not a cortex-a, which probably is
the reason that justifies having specific gcc optimizations that are
different from cortex-a.

So in the end, I'm starting to wonder whether it makes sense to permit
non-100% compatible armv7 chips to coexist in the same kernel :-/

Otherwise we could do what already exists on x86, which is to let the
user select which chip he wants to optimize for. I have no idea on the
subject to be honnest.

Best regards,
Willy
