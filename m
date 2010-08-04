From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Aug 2010 12:30:47 +0100
Subject: [PATCH] Remove ARM default configurations which duplicate
	omap3_defconfig
In-Reply-To: <20100804053533.GB6840@atomide.com>
References: <20100803201921.GA18698@kyllikki.org>
	<20100804053533.GB6840@atomide.com>
Message-ID: <20100804113047.GA6852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 08:35:36AM +0300, Tony Lindgren wrote:
> * Vincent Sanders <vince@simtec.co.uk> [100803 23:23]:
> > These configurations are no longer useful as the systems they support
> > are covered by the generic omap3_defconfig
> 
> Since the defconfigs will stay around at least for a while
> in the compacted form..
> 
> .. And until we have sorted out how to deal with which drivers
> need to be compiled in or as modules for each board, I'd
> rather keep these defconfigs around for now.

That's a user optimization more than anything else.

> Can we just disable building these with some blacklist
> in Kautobuild?

That's no the point.  The point is that there's too many of these things.
Most other SoCs get away with far fewer defconfigs than OMAP does, and I
don't see why OMAP should get any kind of special treatment on this.

> So Not-yet-acked-by until some Kconfig issues are sorted out :)

We've known that the defconfig situation is a hot potato since just
after the last merge window, and we should consider ourselves lucky
that through Uwe's work, Linus has stepped back from removing all
the defconfigs.  Had that not happened, we would now be looking at
all the defconfigs being removed.

I've also been on at people throughout the last three months over this
issue, and it's gained very little traction.  What's waiting another
three months going to achieve?  All that I can see is it'll just be a
delay of execution.

So, I'm going to give it a week, and then I'm applying this patch.  As
Linus said when he was talking about removing all the defconfigs, if
people want to keep them around, put them on a website or similar.  We've
already had enough time to sort something out.
