From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 7 Apr 2014 18:16:24 +0100
Subject: disabling MMU of ARMv7-A
In-Reply-To: <20140407103312.GA7528@n2100.arm.linux.org.uk>
References: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
 <20140328104349.GG21330@arm.com>
 <20140407095629.GA3951@e103592.cambridge.arm.com>
 <20140407103312.GA7528@n2100.arm.linux.org.uk>
Message-ID: <20140407171624.GB3951@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 11:33:12AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 07, 2014 at 10:56:36AM +0100, Dave Martin wrote:
> > Agreed -- CONFIG_MMU=n does not need to imply that the MMU is turned off:
> > everything must be indentity-mapped (VA = PA), but it is still desirable
> > to define attributes.  For SMP, it's *necessary* to define attributes,
> > otherwise we can't guarantee working spinlocks etc.
> 
> It's also necessary for UP as well, as the load-exclusive and
> store-exclusive must still work.  Remember these instructions get used
> for more than just spinlocks.

Agreed.

Nothing in head-nommu.S seems to create any initial page tables or
turn on the MMU, although we do set up an MPU instead if there is one,

Is !MMU known to work with v6 and later?  I'm starting to have doubts.

My understanding of the ARM ARM is that a system may generate an abort
if ldrex/strex is attempted with the MMU off, though there are at least
some platforms that don't do that.

Cheers
---Dave
