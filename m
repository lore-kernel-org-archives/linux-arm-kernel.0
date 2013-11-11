From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Nov 2013 10:31:49 +0000
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131111090810.GI14892@pengutronix.de>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <20131111090810.GI14892@pengutronix.de>
Message-ID: <20131111103149.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 10:08:10AM +0100, Uwe Kleine-K?nig wrote:
> Hello Will,
> 
> it seems the last patch breaks on efm32:
> 
> arch/arm/lib/changebit.S: Assembler messages:
> arch/arm/lib/changebit.S:15: Error: architectural extension `mp' is not allowed for the current base architecture

EFM32 support is not available on either Will's nor my tree, therefore
this is new breakage which we're going to have to fix during the -rc
series.

My view is that we've tried to do too much this merge window: we've
had rather a large number of conflicts of all kinds not only between
patch series (such as the BE series and others) as well as a large
number of build problems caused by changes via my tree interfering
with changes from the arm-soc tree.

In other words, I think that both arm-soc and myself need to push back
and slow things down a bit, and merge less during each cycle, especially
if it is submitted later than about -rc3.
