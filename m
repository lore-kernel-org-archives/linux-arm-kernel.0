From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 15 Oct 2010 14:38:15 -0400 (EDT)
Subject: iwmmxt signal frame handling
In-Reply-To: <201010151540.07982.arnd@arndb.de>
References: <201010141609.10889.arnd@arndb.de>
	<AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
	<AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
	<201010151540.07982.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1010151426030.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Oct 2010, Arnd Bergmann wrote:

> On Friday 15 October 2010 15:32:04 Eric Miao wrote:
> > > Acked-by: Eric Miao <eric.y.miao@gmail.com>
> > >
> > 
> > This also passes the internal iwmmxt test, Haojian please add your
> > Tested-by please.
> 
> Can you also confirm that the previous behaviour is broken?
> If it is, the patch is probably a candidate for the stable trees.

Hard to confirm.  The only way not to have TIF_USING_IWMMXT set is to 
use old pre-EABI binaries, which are relying on the kernel emulated FPA 
instructions for floating point, and nothing in those days might have 
cared about extensions to the ucontext layout at all, or even have used 
iwmmxt.  While this is a correctness fix, in practice this never 
mattered.

And we're talking about mixed ABI environments which existed many years 
ago, like prior the Git era.  Hardly a stable tree candidate.


Nicolas
